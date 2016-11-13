//
// Created by Филипп Панфилов on 09/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController : UIViewController {
    private let loginModel = try! AppDelegate.assembly.resolve() as LoginModel

    @IBOutlet weak var codeLabel: UILabel?
    @IBOutlet weak var errorLabel: UILabel?
    @IBOutlet weak var URLLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel!.isHidden = true
        codeLabel?.text = ""
        URLLabel?.text = ""
        loginModel.loadDeviceCode { (authResponse) in
            self.codeLabel?.text = authResponse.userCode
            self.URLLabel?.text = authResponse.verificationURL
        }
        loginModel.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loginModel.invalidateTimer()
    }
}

extension LoginViewController: LoginModelDelegate {
    func loginModelDidLogin(loginModel: LoginModel) {
        self.dismiss(animated: true, completion: nil)
    }
}
