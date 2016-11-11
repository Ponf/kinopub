//
// Created by Филипп Панфилов on 09/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation

class DelegatesStorage {
    var delegates: NSHashTable<AnyObject>

    // MARK: - Init
    init() {
        delegates = NSHashTable.weakObjects()
        return
    }

    // MARK: - Public
    func addDelegate(delegate: AnyObject) {
        delegates.add(delegate)
    }

    func removeDelegate(delegate: AnyObject) {
        delegates.remove(delegate)
    }

    func enumerateDelegatesWithBlock(delegateBlock: (_ delegate: AnyObject) -> ()) {
        for delegate in (delegates.copy() as AnyObject).objectEnumerator() {
            delegateBlock(delegate as AnyObject)
        }
    }

}
