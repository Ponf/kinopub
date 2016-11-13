//
// Created by Филипп Панфилов on 09/11/16.
// Copyright (c) 2016 babystep.tv. All rights reserved.
//

import Foundation
import Dip
//import DipUI

class ModelsAssembly {
    static func assembly() -> DependencyContainer {
        return DependencyContainer { container in
            unowned let container = container
//            DependencyContainer.uiContainers = [container]
//
//            container.register(tag: "ViewController") { ViewController() }
//                    .resolvingProperties { container, controller in
//                        controller.animationsFactory = try container.resolve() as AnimatonsFactory
//                    }
            
            container.register(ComponentScope.singleton) {
                AccountManagerImp() as AccountManager
            }

            container.register() {try LoginModel(accountManager: container.resolve()) }

//            container.register { AuthFormBehaviourImp(apiClient: $0) as AuthFormBehaviour }
//            container.register { container as AnimationsFactory }
//            container.register { view in ShakeAnimationImp(view: view) as ShakeAnimation }
//            container.register { APIClient(baseURL: NSURL(string: "http://localhost:2368")!) as ApiClient }
        }
    }

}
