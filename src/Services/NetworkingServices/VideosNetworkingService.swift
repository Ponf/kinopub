//
// Created by Филипп Панфилов on 13/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class VideosNetworkingService {
    let requestFactory: RequestFactory

    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
    }

    func loadVideos(onPage page:Int, completed: @escaping (_ videos: Array<VideoItem>?) -> ()) {
        let request = requestFactory.loadVideosRequest(onPage: page)
        request.validate().responseArray(keyPath: "items")  { (response: DataResponse<[VideoItem]>) in
            switch response.result {
            case .success:
                if (response.response?.statusCode == 200) {
                    completed(response.result.value)
                }
                break
            default:
                break
            }
        }
    }
    
}
