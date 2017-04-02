//
// Created by Филипп Панфилов on 09/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation
import Dip

class ModelsAssembly {
    static func assembly() -> DependencyContainer {
        return DependencyContainer { container in
            unowned let container = container

            //Singletons:
            container.register(ComponentScope.singleton) {
                AccountManagerImp() as AccountManager
            }

            //Models
            container.register() {try LoginModel(accountManager: container.resolve()) }
            container.register() {try VideoItemsModel(accountManager: container.resolve()) }
        }
    }

}
