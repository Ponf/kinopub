//
// Created by Филипп Панфилов on 10/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class AccountNetworkingService {
    var requestFactory: RequestFactory

    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
    }

    func notifyAboutDevice(completed: @escaping (_ error: Error?) -> ()) {
        //TODO: check that requestFactory has account
        requestFactory.notifyAboutDeviceRequest().validate().responseJSON() { response in
                    switch response.result {
                    case .success:
                        completed(nil)
                    case .failure(let error):
                        completed(error)
                }
        }
    }
//
//    func renewAccessToken(with refreshToken: String, completed: @escaping (_ responseObject: TokenResponse?, _ error: Error?) -> ()) {
//        requestFactory.renewAccessTokenRequest(with: refreshToken).validate()
//                .responseObject { (response: DataResponse<TokenResponse>) in
//                    switch response.result {
//                    case .success:
//                        completed(response.result.value, nil)
//                        break
//                    default:
//                        break
//                    }
//                }
//    }
}
