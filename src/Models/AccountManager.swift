//
// Created by Филипп Панфилов on 09/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

protocol AccountManager: class {
    var account: KinopubAccount? { get }
    var hasAccount: Bool { get }
    var requestFactory: RequestFactory { get }
    func addDelegate(delegate: AccountManagerDelegate)
    func createAccount(tokenData: TokenResponse)
    func silentlyUpdateAccountWith(accessToken token: String, refreshToken: String)
    func logoutAccount()
}

protocol AccountManagerDelegate {
    func accountManager(accountManager: AccountManager, didLoginToAccount account: KinopubAccount)
    func accountManagerDidLogout(accountManager: AccountManager)
}

extension AccountManagerDelegate {
    func accountManager(accountManager: AccountManager, didLoginToAccount account: KinopubAccount) {
        //Optional
    }

    func accountManagerDidLogout(accountManager: AccountManager) {
        //Optional
    }
}

class AccountManagerImp: AccountManager {
    var delegatesStorage = DelegatesStorage()
    let requestFactory: RequestFactory
    let accountNetworkingService: AccountNetworkingService

    var account: KinopubAccount?
    var hasAccount: Bool {
        return account != nil
    }
    
    init() {
        requestFactory = RequestFactory()
        accountNetworkingService = AccountNetworkingService(requestFactory: requestFactory)
        checkIfAccountExist()
    }
    
    func addDelegate(delegate: AccountManagerDelegate) {
        delegatesStorage .addDelegate(delegate: delegate as AnyObject)
    }
    
    func createAccount(tokenData: TokenResponse) {
        Defaults[.accessToken] = tokenData.accessToken
        Defaults[.refreshToken] = tokenData.refreshToken
        self.account = KinopubAccount(accessToken: tokenData.accessToken!, refreshToken: tokenData.refreshToken)
        self.loginAndNotifyDelegates()
    }
    
    func silentlyUpdateAccountWith(accessToken token: String, refreshToken: String) {
        Defaults[.accessToken] = token
        Defaults[.refreshToken] = refreshToken
        self.account = KinopubAccount(accessToken: token, refreshToken: refreshToken)
    }

    func logoutAccount() {
        self.logoutAndNotifyDelegates()
    }
    
    private func notifyAboutDeviceIfRequired() {
        if (account == nil) {
            return
        }
        accountNetworkingService.notifyAboutDevice {error in

        }
    }
    
    private func checkIfAccountExist() {
        if let accessToken =  Defaults[.accessToken] {
            self.account = KinopubAccount(accessToken: accessToken, refreshToken: Defaults[.refreshToken])
            self.loginAndNotifyDelegates()
        }
    }
    
    private func loginAndNotifyDelegates() {
        requestFactory.accountManager = self
        delegatesStorage .enumerateDelegatesWithBlock(delegateBlock: { [unowned self] (delegate) in
            (delegate as! AccountManagerDelegate).accountManager(accountManager: self, didLoginToAccount: self.account!)
        })
        self.notifyAboutDeviceIfRequired()
    }

    private func logoutAndNotifyDelegates() {
        //TODO: send request to remove device
        Defaults[.accessToken] = nil
        Defaults[.refreshToken] = nil
        account = nil
        delegatesStorage.enumerateDelegatesWithBlock { [unowned self] (delegate) in
            (delegate as! AccountManagerDelegate).accountManagerDidLogout(accountManager: self)
        }
    }
    
}
