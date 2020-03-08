//
//  LoginPresenter.swift
//  VaionAddServer
//
//  Created by Murat Sudan on 8.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import Foundation

protocol LoginPresenterProtocol {
    
}

class LoginPresenter: LoginPresenterProtocol {
    
    //Properties
    let addServerUsecase: AddServerUsecaseProtocol
    
    init(addServerUsecase: AddServerUsecaseProtocol) {
        self.addServerUsecase = addServerUsecase
    }
}
