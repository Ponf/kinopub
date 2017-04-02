//
// Created by Филипп Панфилов on 10/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class AccountNetworkingService {
    let requestFactory: RequestFactory

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

    
}
