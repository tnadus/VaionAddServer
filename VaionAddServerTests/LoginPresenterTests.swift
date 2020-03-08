//
//  LoginPresenterTests.swift
//  VaionAddServerTests
//
//  Created by Murat Sudan on 8.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import XCTest
@testable import VaionAddServer

class LoginPresenterTests: XCTestCase {
    
    let addServerUsecase = AddServerUsecaseMock()
    let loginView = LoginViewControllerMock()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_start_withOnViewDidLoad_updatesViewWithViewModelWithCorrectValues() {
        let sut = createSUT()
        sut.start()
        XCTAssertEqual(loginView.viewModel.placeholderUsername, "Username")
        XCTAssertEqual(loginView.viewModel.placeholderPassword, "Password")
        XCTAssertEqual(loginView.viewModel.buttonTitleOK, "OK")
        XCTAssertEqual(loginView.viewModel.buttonTitleCancel, "Cancel")
    }
    
    func test_onOKButtonTapped_showsSpinnerOnView() {
        let sut = createSUT()
        sut.start()
        
        let credentials = Credentials(username: "usr", password: "pwd")
        sut.onButtonOKTapped(credentials: credentials)
        XCTAssertTrue(loginView.showSpinnerCalledFlag)
    }
    
    func test_onButtonOKTapped_withValidCredentials_navigatesToResultsScreen() {
        let sut = createSUT()
        sut.start()
        
        addServerUsecase.result = .success
        
        let expect = expectation(description: "onSuccessScreen")
        var onSuccessScreenCalled = false
        sut.onSuccessScreen = {
            expect.fulfill()
            onSuccessScreenCalled = true
        }
        
        let credentials = Credentials(username: "usr", password: "pwd")
        sut.onButtonOKTapped(credentials: credentials)
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertTrue(onSuccessScreenCalled)
        
    }
    
    func test_onButtonOKTapped_withInvalidCredentials_receivesUnauthorized() {
        let sut = createSUT()
        sut.start()
        
        addServerUsecase.result = .login
        
        let expect = expectation(description: "onUnauthorized")
        var onUnauthorizedCalled = false
        sut.onUnauthorized = {
            expect.fulfill()
            onUnauthorizedCalled = true
        }
        
        let credentials = Credentials(username: "usr", password: "pwd")
        sut.onButtonOKTapped(credentials: credentials)
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertTrue(onUnauthorizedCalled)
    }
    
    func test_onButtonOKTapped_withInvalidCredentials_receivesError() {
        let sut = createSUT()
        sut.start()
        
        let error = NSError(domain: "com.vaion.login", code: 500, userInfo: ["description" : "Server Internal Error"])
        addServerUsecase.result = .error(error)
        
        let expect = expectation(description: "onError")
        sut.onError = { err in
            expect.fulfill()
            XCTAssertEqual((err as NSError).code, 500)
        }
        
        let credentials = Credentials(username: "usr", password: "pwd")
        sut.onButtonOKTapped(credentials: credentials)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_onOKButtonTapped_hidesSpinnerFromView() {
        let sut = createSUT()
        sut.start()
        
        let expect = expectation(description: "onError")
        let credentials = Credentials(username: "usr", password: "pwd")
        sut.onButtonOKTapped(credentials: credentials)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expect.fulfill()
            XCTAssertTrue(self.loginView.hideSpinnerCalledFlag)
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_onButtonCancelTapped_receivesCancelled() {
        let sut = createSUT()
        sut.start()
        
        let expect = expectation(description: "onCancelled")
        sut.onCancelled = {
            expect.fulfill()
        }
        sut.onButtonCancelTapped()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

//MARK: Helpers
extension LoginPresenterTests {

    func createSUT() -> LoginPresenter {
        let sut = LoginPresenter(addServerUsecase: addServerUsecase)
        sut.managedView = loginView
        return sut
    }
    
    class LoginViewControllerMock: LoginViewProtocol {
        
        //Properties
        var viewModel: LoginViewModel = LoginViewModel(placeholderUsername: "", placeholderPassword: "", buttonTitleOK: "", buttonTitleCancel: "")
        var showSpinnerCalledFlag = false
        var hideSpinnerCalledFlag = false
        
        func updateView(viewModel: LoginViewModel) {
            self.viewModel = viewModel
        }
        
        func showSpinner() {
            showSpinnerCalledFlag = true
        }
        
        func hideSpinner() {
            hideSpinnerCalledFlag = true
        }
    }
}
