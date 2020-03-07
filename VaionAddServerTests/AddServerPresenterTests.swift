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
    
    func test_onOKButtonTapped_withIPAddress_showsAndHideSpinnerOnView() {
        
        let sut = createSUT()
        sut.start()
        
        sut.onOKButtonTapped(ipAddress: ipAddressDefault)
        XCTAssertTrue(managedView.showSpinnerCalledFlag)
        XCTAssertTrue(managedView.hideSpinnerCalledFlag)
    }
    
    func test_onOKButtonTapped_withIPAddressDoesNotRequireCredentials_navigatesToResultsScreen() {
        let sut = createSUT()
        sut.start()
        
        addServerUsecase.result = .success
    
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
    
    func test_onOKButtonTapped_withIPAddressRequiresCredentials_navigatesToLoginScreen() {
        let sut = createSUT()
        sut.start()
        
        addServerUsecase.result = .login
        
        let expect = expectation(description: "onLoginScreen")
        var onLoginScreenCalled = false
        sut.onLoginScreen = {
            expect.fulfill()
            onLoginScreenCalled = true
        }
        
        sut.onOKButtonTapped(ipAddress: ipAddressDefault)
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertTrue(onLoginScreenCalled)
    }
    
    func test_onOKButtonTapped_withIPAddress_receivesError() {
        let sut = createSUT()
        sut.start()
        
        let error = NSError.init(domain: "com.vaion.addserver", code: 999, userInfo: nil)
        addServerUsecase.result = .error(error)
        
        let expect = expectation(description: "onError")
        sut.onError = { err in
            expect.fulfill()
            XCTAssertEqual((err as NSError).domain, "com.vaion.addserver")
        }
        sut.onOKButtonTapped(ipAddress: ipAddressDefault)
        waitForExpectations(timeout: 1.0, handler: nil)
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
        var showSpinnerCalledFlag = false
        var hideSpinnerCalledFlag = false
        
        func updateView(placeholder: String, buttonTitle: String) {
            self.placeholder = placeholder
            self.buttonTitle = buttonTitle
        }
        
        func showSpinner() {
            showSpinnerCalledFlag = true
        }
        
        func hideSpinner() {
            hideSpinnerCalledFlag = true
        }
    }
    
    class AddServerUsecaseMock: AddServerUsecaseProtocol {

        var ipAddress: String = ""
        var result: AddServerUsecase.Result = .success
        
        func addServer(ipAddress: String, onCompletion: (AddServerUsecase.Result) -> Void) {
            self.ipAddress = ipAddress
            onCompletion(result)
        }
    }
}
