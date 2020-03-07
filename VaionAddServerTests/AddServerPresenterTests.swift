//
//  AddServerPresenterTests.swift
//  VaionAddServerTests
//
//  Created by Murat Sudan on 7.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import XCTest
@testable import VaionAddServer

class AddServerPresenterTests: XCTestCase {
    
    let managedView = AddServerViewControllerMock()
    let addServerUsecase = AddServerUsecaseMock()
    let ipAddressDefault = "127.0.0.1"

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_start_withOnViewDidLoad_updatesViewPlaceholderAndButtonTitle() {
        let sut = createSUT()
        sut.start()
        XCTAssertEqual(managedView.placeholder, "IP Address")
        XCTAssertEqual(managedView.buttonTitle, "OK")
    }
    
    func test_onOKButtonTapped_withIPAddress_receivedOnAddServerUsecase() {
        
        let sut = createSUT()
        sut.start()
        
        sut.onOKButtonTapped(ipAddress: ipAddressDefault)
        XCTAssertEqual(addServerUsecase.ipAddress, ipAddressDefault)
    }
    
    func test_onOKButtonTapped_withIPAddressDoesNotRequireCredentials_navigatesToResultsScreen() {
        let sut = createSUT()
        sut.start()
        
        addServerUsecase.noCredentialsNeeded = true
    
        let expect = expectation(description: "onSuccessScreen")
        var onSuccessScreenCalled = false
        sut.onSuccessScreen = {
            expect.fulfill()
            onSuccessScreenCalled = true
        }
        
        sut.onOKButtonTapped(ipAddress: ipAddressDefault)
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertTrue(onSuccessScreenCalled)
    }
    
}

//MARK: Helpers
extension AddServerPresenterTests {
    
    func createSUT() -> AddServerPresenter {
        let sut = AddServerPresenter(addServerUsecase: addServerUsecase)
        sut.managedView = managedView
        return sut
    }
    
    class AddServerViewControllerMock: AddServerViewProtocol {
        
        var placeholder: String = ""
        var buttonTitle: String = ""
        
        func updateView(placeholder: String, buttonTitle: String) {
            self.placeholder = placeholder
            self.buttonTitle = buttonTitle
        }
    }
    
    class AddServerUsecaseMock: AddServerUsecaseProtocol {

        var ipAddress: String = ""
        var noCredentialsNeeded = false
        
        func addServer(ipAddress: String, onCompletion: () -> Void) {
            self.ipAddress = ipAddress
            onCompletion()
        }
    }
    
}
