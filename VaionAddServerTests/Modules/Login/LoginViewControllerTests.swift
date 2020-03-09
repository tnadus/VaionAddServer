//
//  LoginViewControllerTests.swift
//  VaionAddServerTests
//
//  Created by Murat Sudan on 8.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import XCTest
@testable import VaionAddServer

class LoginViewControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_viewDidLoad_startsPresenter() {
        let presenter = LoginPresenterMock()
        let sut = LoginViewController(presenter: presenter)
        _ = sut.view
        
        XCTAssertTrue(presenter.startCalledFlag)
    }
        
    func test_buttonOK_withEmptyUsername_setAsDisabled() {
        let presenter = LoginPresenterMock()
        let sut = LoginViewController(presenter: presenter)
        _ = sut.view
        
        sut.textFieldUsername.text = ""
        XCTAssertFalse(sut.buttonOK.isEnabled)
    }
    
    func test_buttonOK_withNonEmptyUsername_setAsEnabled() {
        let presenter = LoginPresenterMock()
        let sut = LoginViewController(presenter: presenter)
        _ = sut.view
        
        sut.textFieldUsername.text = "usr"
        sut.textFieldUsername.sendActions(for: .editingChanged)
        XCTAssertTrue(sut.buttonOK.isEnabled)
    }
    
    func test_buttonOKTapped_callsPresenterButtonOKTap() {
        let presenter = LoginPresenterMock()
        let sut = LoginViewController(presenter: presenter)
        _ = sut.view
        
        sut.textFieldUsername.text = "usr"
        sut.textFieldUsername.sendActions(for: .editingChanged)
        sut.onButtonOKTapped(sut.buttonOK)
        XCTAssertTrue(presenter.onButtonOKTapCalledFlag)
    }
    
    func test_buttonCancelTapped_callsPresenterButtonCancelTap() {
        let presenter = LoginPresenterMock()
        let sut = LoginViewController(presenter: presenter)
        _ = sut.view
        
        sut.onButtonCancelTapped(sut.buttonCancel)
        XCTAssertTrue(presenter.onButtonCancelTapCalledFlag)
    }
}

extension LoginViewControllerTests {
    
    class LoginPresenterMock: LoginPresenterProtocol, LoginPresenterNavigatorProtocol {
 
        var onSuccessScreen: (() -> Void)?
        var onUnauthorized: (() -> Void)?
        var onError: ((Error) -> Void)?
        
        var startCalledFlag = false
        var onButtonOKTapCalledFlag = false
        var onButtonCancelTapCalledFlag = false
        
        func start() {
            startCalledFlag = true
        }
        
        func onButtonOKTapped(credentials: Credentials) {
            onButtonOKTapCalledFlag = true
        }
        
        func onButtonCancelTapped() {
            onButtonCancelTapCalledFlag = true
        }
    }
    
}
