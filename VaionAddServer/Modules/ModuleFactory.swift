//
//  ModuleFactory.swift
//  VaionAddServer
//
//  Created by Murat Sudan on 7.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import Foundation

class ModuleFactory {
    
    func makeAddServerModule() -> (AddServerViewController, AddServerPresenter) {
        let addServerUsecase = AddServerUsecase()
        let presenter = AddServerPresenter(addServerUsecase: addServerUsecase)
        let vc = AddServerViewController(presenter: presenter)
        return (vc, presenter)
    }
    
    func makeLoginModule() -> (LoginViewController, LoginPresenter) {
        let addServerUsecase = AddServerUsecase()
        let presenter = LoginPresenter(addServerUsecase: addServerUsecase)
        let vc = LoginViewController(presenter: presenter)
        return (vc, presenter)
    }
}
