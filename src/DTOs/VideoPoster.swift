//
// Created by Филипп Панфилов on 13/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation
import ObjectMapper

class VideoPoster: Mappable {
    var small: String?
    var medium: String?
    var big: String?

    required init? (map: Map) {}

    func mapping(map: Map) {
        small <- map["small"]
        medium <- map["medium"]
        big <- map["big"]
    }
}
