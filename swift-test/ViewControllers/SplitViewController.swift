//
//  ViewController.swift
//  swift-test
//
//  Created by Филипп Панфилов on 08/11/16.
//  Copyright © 2016 babystep.tv. All rights reserved.
//

import UIKit
import Dip

func delay(_ delay:Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}

class SplitViewController: UISplitViewController {
    private let accountManager = try! AppDelegate.assembly.resolve() as AccountManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let menuController = self.viewControllers.first as? LeftMenuViewController {
            menuController.delegate = self
        }
        accountManager.addDelegate(delegate: self)
        self.preferredDisplayMode = .primaryOverlay;
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !accountManager.hasAccount {
            showLoginViewController()
        } else {
            delay(1.0) {
                self.hideMenuAnimated()
            }
        }
    }

    fileprivate func hideMenuAnimated() {
        UIView.animate(withDuration: 0.3) {
            self.preferredDisplayMode = UISplitViewControllerDisplayMode.primaryHidden
        }
    }
    
    fileprivate func showLoginViewController() {
                    self.performSegue(withIdentifier: "kShowLoginRequiredSegue", sender: self)
    }
}

extension SplitViewController: UISplitViewControllerDelegate {
    func targetDisplayModeForAction(in svc: UISplitViewController) -> UISplitViewControllerDisplayMode {
        if svc.displayMode == .primaryHidden {
            return .primaryOverlay
        }
        return .primaryHidden
    }
}

extension SplitViewController: LeftMenuViewControllerDelegate {
    func leftMenu(sender: LeftMenuViewController, didSelectItem itemIndex: Int) {
        hideMenuAnimated()
    }
}

extension SplitViewController: AccountManagerDelegate {
    
    func accountManagerDidLogout(accountManager: AccountManager) {
        showLoginViewController()
    }
}
