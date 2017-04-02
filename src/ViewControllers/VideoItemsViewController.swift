//
// Created by Филипп Панфилов on 13/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation
import UIKit

class VideoItemsViewController: UIViewController {
    fileprivate let model = try! AppDelegate.assembly.resolve() as VideoItemsModel
    @IBOutlet weak var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        model.loadVideos()
    }

}

// MARK - UICollectionView delegates
extension VideoItemsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoItemCellReuseIdentifier", for: indexPath) as! VideoItemCell
        cell.configure(with: model.videoItems![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (model.videoItems == nil) {
            return 0
        }
        return (model.videoItems?.count)!
    }
}

extension VideoItemsViewController: VideoItemsModelDelegate {
    func didUpdateVideos(model: VideoItemsModel) {
        collectionView!.reloadData()
    }
}


