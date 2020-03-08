//
//  AddServerUsecaseMock.swift
//  VaionAddServerTests
//
//  Created by Murat Sudan on 8.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import Foundation
@testable import VaionAddServer

class AddServerUsecaseMock: AddServerUsecaseProtocol {
    
    var ipAddress: String = ""
    var result: AddServerUsecase.Result = .success
    
    func addServer(ipAddress: String, credentials: Credentials? = nil, onCompletion: (AddServerUsecase.Result) -> Void) {
        self.ipAddress = ipAddress
        onCompletion(result)
    }
}
