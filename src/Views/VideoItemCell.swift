//
// Created by Филипп Панфилов on 13/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class VideoItemCell: UICollectionViewCell {
    @IBOutlet weak var posterView: UIImageView?
    @IBOutlet weak var titleView: UILabel?

    func configure(with item:VideoItem) {
        titleView!.text = item.videoTitle
        posterView?.af_setImage(withURL: URL(string: (item.videoPosters?.small)!)!)
    }
}
