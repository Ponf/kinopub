//
// Created by Филипп Панфилов on 10/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation
import Alamofire

class RequestFactory {
    var account: KinopubAccount?
    let baseAPIURL = "https://api.service-kp.com/"

    func receiveDeviceCodeRequest() -> DataRequest {
        //TODO: move secrets to Info.plist
        let parameters = [
            "grant_type": "device_code",
            "client_id": "appletv2",
            "client_secret": "***REMOVED***"
        ]
        let requestUrl = baseAPIURL + "oauth2/device"
        return Alamofire.request(requestUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody)
    }

    func receiveCheckCodeApprovedRequest(_ code: String) -> DataRequest {
        //TODO: move secrets to Info.plist
        let parameters = [
                "grant_type": "device_token",
                "client_id": "appletv2",
                "client_secret": "***REMOVED***",
                "code": code
        ]
        let requestUrl = baseAPIURL + "oauth2/device"
        return Alamofire.request(requestUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody)
    }

    func renewAccessTokenRequest(with refreshToken: String) -> DataRequest {
        //TODO: move secrets to Info.plist
        let parameters = [
                "grant_type": "refresh_token",
                "client_id": "appletv2",
                "client_secret": "***REMOVED***",
                "refresh_token": refreshToken
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
        return Alamofire.request(requestUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: self.authorizationHeader())
    }


    private func authorizationHeader() -> [String: String] {
        return ["Authorization": "Bearer \(account!.accessToken)"]
    }

}
