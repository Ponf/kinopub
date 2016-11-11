//
// Created by Филипп Панфилов on 10/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation

protocol LoginModelDelegate: class {
    func loginModelDidLogin(loginModel: LoginModel)
}

class LoginModel {
    let accountManager: AccountManager
    let loginNetworkingService: LoginNetworkingService
    weak var delegate: LoginModelDelegate?
    
    var timer: Timer?
    var code: String?
    
    
    init(accountManager: AccountManager) {
        self.accountManager = accountManager
        loginNetworkingService = LoginNetworkingService(requestFactory: accountManager.requestFactory)
        accountManager.addDelegate(delegate: self)
    }

    func loadDeviceCode(completed:@escaping ((AuthResponse) -> ())) {
        loginNetworkingService.receiveDeviceCode {
            [unowned self] (response, error) in
            if let authData = response {
                self.code = authData.code
                completed(authData)
                self.startTimer(withInterval: authData.refreshInterval)
            } else {
                //TODO: handle error
            }
        }
    }
    
    func invalidateTimer() {
        if let uwTimer = timer {
            if uwTimer.isValid {
                uwTimer.invalidate()
            }
         }
    }

    private func startTimer(withInterval interval: Int?) {
        if (interval == nil) {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(interval!), target: self, selector: #selector(self.checkCodeValidation), userInfo: nil, repeats: true)
    }

    deinit {
        invalidateTimer()
    }
    
    //TODO: remove objc??
    @objc func checkCodeValidation() {
        loginNetworkingService.checkApproved(withCode: code!) { [unowned self] (response, error) in
            if let tokenData = response {
                self.timer?.invalidate()
                
                self.accountManager.createAccount(tokenData: tokenData)
            }
        }
    }
}

extension LoginModel: AccountManagerDelegate {
    func accountManager(accountManager: AccountManager, didLoginToAccount account: KinopubAccount) {
        self.delegate?.loginModelDidLogin(loginModel: self)
    }
}
