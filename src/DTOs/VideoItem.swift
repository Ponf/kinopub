//
// Created by Филипп Панфилов on 13/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation
import ObjectMapper

class VideoItem: Mappable {
    var videoId: Int?
    var videoType: String?
    var videoSubtype: String?
    var videoTitle: String?
    var videoYear: Int?
    var videoCast: String?
    var videoDirector: String?
    var videoGenres: Array<VideoGenre>?
//    var videoCountries: Array<Country>?
    var videoPlot: String?
    var videoVoice: String?
//    var videoDuration: Duration?
    var videoIMDB: Int?
    var videoIMDBRating: Float?
    var videoIMDBVotes: Int?
    var videoKinopoisk: Int?
    var videoKinopoiskRating: Float?
    var videoKinopoiskVotes: Int?
    var videoPosters: VideoPoster?
    var isInWatchlist: Bool?
    var hasAdvert: Bool?

    required init? (map: Map) {}


    func mapping(map: Map) {
        self.videoId <- map["id"]
        self.videoType <- map["type"]
        self.videoSubtype <- map["subtype"]
        self.videoTitle <- map["title"]
        self.videoYear <- map["year"]
        self.videoCast <- map["cast"]
        self.videoDirector <- map["director"]
        self.videoGenres <- map["genres"]
//        self.videoCountries <- map["countries"]
        self.videoPlot <- map["plot"]
        self.videoVoice <- map["voice"]
//        self.videoDuration <- map["duration"]
        self.videoIMDB <- map["imdb"]
        self.videoIMDBRating <- map["imdb_rating"]
        self.videoIMDBVotes <- map["imdb_votes"]
        self.videoKinopoisk <- map["kinopoisk"]
        self.videoKinopoiskRating <- map["kinopoisk_rating"]
        self.videoKinopoiskVotes <- map["kinopoisk_votes"]
        self.videoPosters <- map["posters"]
        self.isInWatchlist <- map["in_watchlist"]
        self.hasAdvert <- map["advert"]
    }

}
