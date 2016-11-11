//
// Created by Филипп Панфилов on 10/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class LoginNetworkingService {
    var requestFactory: RequestFactory
    
    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
    }

    func receiveDeviceCode(completed: @escaping (_ responseObject: AuthResponse?, _ error: Error?) -> ()) {
        requestFactory.receiveDeviceCodeRequest()
            .responseObject { (response: DataResponse<AuthResponse>) in
                switch response.result {
                    case .success:
                        completed(response.result.value, nil)
                        break
                    case .failure(let error):
                        completed(nil, error)
                    }
            }
    }

    func checkApproved(withCode code: String, completed: @escaping (_ responseObject: TokenResponse?, _ error: Error?) -> ()) {
        requestFactory.receiveCheckCodeApprovedRequest(code)
            .responseObject { (response: DataResponse<TokenResponse>) in
                switch response.result {
                    case .success:
                        if (response.response?.statusCode == 200) {
                            completed(response.result.value, nil)
                        }
                        break
                    default:
                        break
                }

            }
    }

}
