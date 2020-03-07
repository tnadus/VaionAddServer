//
//  AddServerUsecase.swift
//  VaionAddServer
//
//  Created by Murat Sudan on 7.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import Foundation

protocol AddServerUsecaseProtocol {
    func addServer(ipAddress: String, onCompletion: (AddServerUsecase.Result) -> Void)
}

class AddServerUsecase: AddServerUsecaseProtocol {
    
    enum Result {
        case success
        case login
        case error(Error)
    }
    
    func addServer(ipAddress: String, onCompletion: (Result) -> Void) {
        
    }
}
