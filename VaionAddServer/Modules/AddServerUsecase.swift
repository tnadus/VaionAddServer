//
//  AddServerUsecase.swift
//  VaionAddServer
//
//  Created by Murat Sudan on 7.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import Foundation

protocol AddServerUsecaseProtocol {
    func addServer(ipAddress: String, onCompletion: @escaping (AddServerUsecase.Result) -> Void)
}

class AddServerUsecase: AddServerUsecaseProtocol {
    
    enum Result {
        case success
        case login
        case error(Error)
    }

    //Properties
    let networking: NetworkingProtocol

    init(networking: NetworkingProtocol = Networking.sharedInstance) {
        self.networking = networking
    }
    
    func addServer(ipAddress: String, onCompletion: @escaping (Result) -> Void) {
        networking.connectToServer(ipAddress: ipAddress, credentials: nil) { (response) in
            if response.success {
                onCompletion(.success)
            } else if response.code == 401 {
                onCompletion(.login)
            } else {
                let error = NSError.init(domain: "com.vaion.addserver", code: response.code, userInfo: ["description" : response.message])
                onCompletion(.error(error))
            }
        }
    }
}
