//
//  FlowAddServerTests.swift
//  VaionAddServerTests
//
//  Created by Murat Sudan on 8.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import XCTest
@testable import VaionAddServer

class FlowAddServerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_flow_start_navigatesToAddServerScreen() {
        let router = RouterMock()
        let moduleFactory = ModuleFactory()
        let sut = FlowAddServer(router: router, moduleFactory: moduleFactory)
        sut.start()
        
        XCTAssertTrue(router.lastPushedViewController is AddServerViewController)
    }
    
    func test_flow_addServerScreenWithNoCredentialRequiredIPAddress_navigatesToAddServerSuccessScreen() {

        let router = RouterMock()
        let moduleFactory = ModuleFactory()
        let sut = FlowAddServer(router: router, moduleFactory: moduleFactory)
        
        let expect = expectation(description: "navigatesToSuccessScreen")
        sut.start { (navigator) in
            navigator.onSuccessScreen?()
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertTrue(router.lastPushedViewController is AddServerSuccessViewController)
    }
    
    func test_flow_addServerScreenWithCredentialsRequiredIPAddress_navigatesToLoginScreen() {
        
        let router = RouterMock()
        let moduleFactory = ModuleFactory()
        let sut = FlowAddServer(router: router, moduleFactory: moduleFactory)
        
        let expect = expectation(description: "navigatesToLoginScreen")
        sut.start { (navigator) in
            navigator.onLoginScreen?()
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertTrue(router.lastPushedViewController is LoginViewController)
    }
    
    func test_flow_addServerScreenWithCredentialsRequiredIPAddress_showsErrorAlert() {
        
        let router = RouterMock()
        let moduleFactory = ModuleFactory()
        let sut = FlowAddServer(router: router, moduleFactory: moduleFactory)
        
        let expect = expectation(description: "showsErrorAlert")
        sut.start { (navigator) in
            let error = NSError(domain: "com.vaion.addServer", code: 500, userInfo: nil)
            navigator.onError?(error)
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertTrue(router.lastPresentedViewController is UIAlertController)
    }
    
    func test_flow_loginScreenWithValidCredentials_navigatesToAddServerSuccessScreen() {
        
        let router = RouterMock()
        let moduleFactory = ModuleFactory()
        let sut = FlowAddServer(router: router, moduleFactory: moduleFactory)
        
        let expect = expectation(description: "navigatesToSuccessScreen")
        sut.start()
        sut.navigateToLoginScreen { (navigator) in
            navigator.onSuccessScreen?()
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertTrue(router.lastPushedViewController is AddServerSuccessViewController)
    }
}

//MARK: Helpers
extension FlowAddServerTests {
    
    class RouterMock: Router {
        
        var lastPresentedViewController: UIViewController? = nil
        var lastPushedViewController: UIViewController? = nil
        
        func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?) {
            lastPresentedViewController = viewControllerToPresent
            completion?()
        }
        
        func pushViewController(_ viewController: UIViewController, animated: Bool) {
            lastPushedViewController = viewController
        }
    }
}
