//
// Created by Филипп Панфилов on 08/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation
import UIKit

protocol LeftMenuViewControllerDelegate: class {
    func leftMenu(sender: LeftMenuViewController, didSelectItem itemIndex: Int)
}

class LeftMenuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView?
    weak var delegate: LeftMenuViewControllerDelegate?
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.setNeedsFocusUpdate()
//        self.updateFocusIfNeeded()
//    }
//    
//    override var preferredFocusEnvironments: [UIFocusEnvironment] {
//        return [tableView!];
//    }
}

//MARK - UITableViewDataSource
extension LeftMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier:"MenuCellReuseIdentifier", for: indexPath)
    }
}

//MARK - UITableViewDelegate
extension LeftMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.leftMenu(sender: self, didSelectItem: indexPath.row)
    }

}
