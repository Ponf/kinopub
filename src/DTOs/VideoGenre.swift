//
// Created by Филипп Панфилов on 13/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation
import ObjectMapper

class VideoGenre: Mappable {
    var id: Int?
    var title: String?
//    var type: GenreType?

    required init? (map: Map) {}

    func mapping(map: Map) {
        self.id <- map["id"]
        self.title <- map["title"]
//        type <- map["type"]
    }
}
