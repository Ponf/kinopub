//
// Created by Филипп Панфилов on 13/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation

protocol VideoItemsModelDelegate: class {
    func didUpdateVideos(model: VideoItemsModel)
}

class VideoItemsModel: AccountManagerDelegate {
    weak var delegate: VideoItemsModelDelegate?
    var videoItems: [VideoItem]?

    let networkingService: VideosNetworkingService
    let accountManager: AccountManager

    init(accountManager: AccountManager) {
        networkingService = VideosNetworkingService(requestFactory: accountManager.requestFactory)
        self.accountManager = accountManager
    }

    func loadVideos() {
        if (accountManager.hasAccount) {
            networkingService.loadVideos(onPage: 0) { [weak self] (videos) in
                guard let strongSelf = self else { return }
                strongSelf.videoItems = videos
                strongSelf.delegate?.didUpdateVideos(model: strongSelf)
            }
        }
    }
    
    func accountManager(accountManager: AccountManager, didLoginToAccount account: KinopubAccount) {
        loadVideos()
    }
}
