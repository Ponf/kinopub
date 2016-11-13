//
// Created by Филипп Панфилов on 10/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation
import ObjectMapper

class TokenResponse: Mappable {
    var accessToken: String?
    var refreshToken: String?

    required init? (map: Map) {

    }

    func mapping(map: Map) {
        accessToken <- map["access_token"]
        refreshToken <- map["refresh_token"]
    }
}
