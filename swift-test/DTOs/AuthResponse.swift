//
// Created by Филипп Панфилов on 10/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation
import ObjectMapper

class AuthResponse: Mappable {
    var code: String?
    var userCode: String?
    var verificationURL: String?
    var refreshInterval: Int?

    required init? (map: Map) {
        
    }

    func mapping(map: Map) {
        code <- map["code"]
        userCode <- map["user_code"]
        verificationURL <- map["verification_uri"]
        refreshInterval <- map["interval"]
    }
}
