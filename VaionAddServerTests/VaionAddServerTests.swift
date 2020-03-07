//
//  VaionAddServerTests.swift
//  VaionAddServerTests
//
//  Created by Murat Sudan on 7.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import XCTest
@testable import VaionAddServer

class VaionAddServerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testModuleFactoryNotNil() {
        XCTAssertNotNil(ModuleFactory())
    }
    
    func testModuleFactoryMakesAddServerModule() {
        let (vc, presenter) = ModuleFactory().makeAddServerModule()
        XCTAssertTrue(vc is AddServerViewController)
        XCTAssertTrue(presenter is AddServerPresenter)
    }
}
