//
//  ModuleFactoryTests.swift
//  VaionAddServerTests
//
//  Created by Murat Sudan on 7.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import XCTest
@testable import VaionAddServer

class ModuleFactoryTests: XCTestCase {
    
    func testModuleFactoryMakesAddServerModule() {
        let (vc, presenter) = ModuleFactory().makeAddServerModule()
        XCTAssertTrue(vc is AddServerViewController)
        XCTAssertTrue(presenter is AddServerPresenter)
    }
    
    func test_moduleFactory_makesLoginModule() {
        let (vc, presenter) = ModuleFactory().makeLoginModule(ipAddress: "127.0.0.1")
        XCTAssertTrue(vc is LoginViewController)
        XCTAssertTrue(presenter is LoginPresenter)
    }
    
    func test_moduleFactory_makesAddServerSuccessModule() {
        let vc = ModuleFactory().makeAddServerSuccessModule()
        XCTAssertTrue(vc is AddServerSuccessViewController)
    }
}
