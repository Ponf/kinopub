//
// Created by Филипп Панфилов on 10/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation
import Alamofire

class RequestFactory {
    var account: KinopubAccount? {
        return accountManager!.account
    }
    let baseAPIURL = "https://api.service-kp.com/"
    
    //TODO: move secrets to Info.plist
    let clientId = "appletv2"
    let clientSecret = ""
    
    var accountManager: AccountManager?
    var authorizedSessionManager: SessionManager?


    func receiveDeviceCodeRequest() -> DataRequest {
        let parameters = [
            "grant_type": "device_code",
            "client_id": clientId,
            "client_secret": clientSecret
        ]
        let requestUrl = baseAPIURL + "oauth2/device"
        return Alamofire.request(requestUrl, method: .post, parameters: parameters, encoding:URLEncoding.httpBody)
    }

    func receiveCheckCodeApprovedRequest(_ code: String) -> DataRequest {
        let parameters = [
                "grant_type": "device_token",
                "client_id": clientId,
                "client_secret": clientSecret,
                "code": code
        ]
        let requestUrl = baseAPIURL + "oauth2/device"
        return Alamofire.request(requestUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody)
    }
    
    func notifyAboutDeviceRequest() -> DataRequest {
        let parameters = [
            "title": UIDevice().name,
            "hardware": "AppleTV",
            "software": UIDevice().systemName+"/"+UIDevice().systemVersion+" KinopubTV/Filipp"
        ]
        let requestUrl = baseAPIURL + "v1/device/notify"
        
        return sessionManager().request(requestUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody)
    }


    
    private func sessionManager() -> SessionManager {
        if (authorizedSessionManager != nil) {
            return authorizedSessionManager!
        }
        
        let configuration = URLSessionConfiguration.default
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        
        let authHandler = OAuthHandler(accessToken: account!.accessToken)
        authHandler.delegate = self
        sessionManager.adapter = authHandler
        sessionManager.retrier = authHandler
        authorizedSessionManager = sessionManager
        return authorizedSessionManager!
    }
}

extension RequestFactory: OAuthHandlerDelegate {
    func handlerDidUpdate(accessToken token: String, refreshToken: String) {
        accountManager!.silentlyUpdateAccountWith(accessToken: token, refreshToken: refreshToken)
    }
    
    func handlerDidFailedToUpdateToken() {
        accountManager!.logoutAccount()
    }
    
    func refreshTokenRequest() -> DataRequest {
        let parameters = [
            "grant_type": "refresh_token",
            "client_id": clientId,
            "client_secret": clientSecret,
            "refresh_token": account?.refreshToken
        ]
        let requestUrl = baseAPIURL + "oauth2/device"
        return Alamofire.request(requestUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
    }
}

