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
    let credentials = Credentials(username: "usr", password: "pwd")
    
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
        
        sut.onButtonOKTapped(credentials: credentials)
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertTrue(onSuccessScreenCalled)
        
    }
    
    func test_onButtonOKTapped_withInvalidCredentials_receivesUnauthorized() {
        let sut = createSUT()
        sut.start()
        
        addServerUsecase.result = .login
        
        sut.onButtonOKTapped(credentials: credentials)
        XCTAssertTrue(loginView.resetCredentialsCalledFlag)
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
        
        sut.onButtonOKTapped(credentials: credentials)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_onOKButtonTapped_hidesSpinnerFromView() {
        let sut = createSUT()
        sut.start()
        
        let expect = expectation(description: "onError")
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
        let sut = LoginPresenter(addServerUsecase: addServerUsecase,
                                 ipAddress: "127.0.0.1")
        sut.managedView = loginView
        return sut
    }
    
    class LoginViewControllerMock: LoginViewProtocol {

        //Properties
        var viewModel: LoginViewModel = LoginViewModel(placeholderUsername: "", placeholderPassword: "", buttonTitleOK: "", buttonTitleCancel: "")
        var showSpinnerCalledFlag = false
        var hideSpinnerCalledFlag = false
        var resetCredentialsCalledFlag = false
        
        func updateView(viewModel: LoginViewModel) {
            self.viewModel = viewModel
        }
        
        func showSpinner() {
            showSpinnerCalledFlag = true
        }
        
        func hideSpinner() {
            hideSpinnerCalledFlag = true
        }
        
        func resetCredentials() {
            resetCredentialsCalledFlag = true
        }
    }
}
