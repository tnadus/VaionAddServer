//
//  AddServerUsecaseTests.swift
//  VaionAddServerTests
//
//  Created by Murat Sudan on 8.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import XCTest
@testable import VaionAddServer

class AddServerUsecaseTests: XCTestCase {
    
    let networking = NetworkingMock()
    let ipAddressDefault = "127.0.0.1"

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func test_addServer_withIPAddressRequiresNoAuth_asksForNoCredentials() {
        let sut = createSUT()
        let expect = expectation(description: "noCredentials")
        
        sut.addServer(ipAddress: ipAddressDefault) { (result) in
            if case .success = result {
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_addServer_withIPAddressRequiresAuth_asksForCredentials() {
        let sut = createSUT()
        let expect = expectation(description: "requiresCredentials")
        networking.responseConnect = NetworkingResponse(success: false, code: 401, message: "")
        
        sut.addServer(ipAddress: ipAddressDefault) { (result) in
            if case .login = result {
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_addServer_withIPAddress_receivesErrorOtherThan401() {
        let sut = createSUT()
        let expect = expectation(description: "receivesError")
        networking.responseConnect = NetworkingResponse(success: false, code: 500, message: "")
        
        sut.addServer(ipAddress: ipAddressDefault) { (result) in
            if case .error(let err) = result {
                expect.fulfill()
                XCTAssertEqual((err as NSError).code, 500)
            }
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}

//MARK: Helpers
extension AddServerUsecaseTests {
    
    func createSUT() -> AddServerUsecase {
        return AddServerUsecase(networking: networking)
    }
    
    class NetworkingMock: NetworkingProtocol {
        
        var serverGroup = [ServerGroup]()
        var responseConnect = NetworkingResponse(success: true, code: 0, message: "")
        var responseConfig = NetworkingResponse(success: true, code: 0, message: "")
        
        func connectToServer(ipAddress: String, credentials: Credentials?, completionHandler: @escaping (NetworkingResponse) -> Void) {
            completionHandler(responseConnect)
        }
        
        func getServerGroups(completionHandler: @escaping ([ServerGroup]) -> Void) throws {
            completionHandler(serverGroup)
        }
        
        func configureServer(name: String, serverGroupName: String?, newServerGroup: ServerGroup?, completionHandler: @escaping (NetworkingResponse) -> Void) throws {
            completionHandler(responseConfig)
        }
    }
}
