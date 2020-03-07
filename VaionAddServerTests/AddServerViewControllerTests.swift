//
//  AddServerViewControllerTests.swift
//  VaionAddServerTests
//
//  Created by Murat Sudan on 7.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import XCTest
@testable import VaionAddServer

class AddServerViewControllerTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_viewDidLoad_startsPresenter() {
        
        let presenter = AddServerPresenterMock()
        let sut = AddServerViewController(presenter: presenter)
        _ = sut.view
        XCTAssertTrue(presenter.startCalledFlag)
    }
    
    func test_OKButton_setDisabled_emptyIPAddressLabel() {
        let presenter = AddServerPresenterMock()
        let sut = AddServerViewController(presenter: presenter)
        _ = sut.view
        
        sut.textFieldIPAddress.text = ""
        XCTAssertEqual(sut.buttonOK.isEnabled, false)
    }
    
    func test_OKButton_withNonEmptyIPAddress_setEnabled() {
        let presenter = AddServerPresenterMock()
        let sut = AddServerViewController(presenter: presenter)
        _ = sut.view
        
        sut.textFieldIPAddress.text = "127"
        sut.textFieldIPAddress.sendActions(for: .editingChanged)
        XCTAssertEqual(sut.buttonOK.isEnabled, true)
    }
    
    func test_OKButtonTapped_callsPresenterButtonTap() {
        let presenter = AddServerPresenterMock()
        let sut = AddServerViewController(presenter: presenter)
        _ = sut.view
        
        sut.onButtonOKTapped(sut.buttonOK as Any)
        XCTAssertEqual(presenter.buttonOKTappedCalledFlag, true)
    }

}

extension AddServerViewControllerTests {
    
    class AddServerPresenterMock: AddServerPresenterProtocol {
        
        var startCalledFlag = false
        var buttonOKTappedCalledFlag = false
        
        func start() {
            startCalledFlag = true
        }
        
        func onOKButtonTapped(ipAddress: String) {
            buttonOKTappedCalledFlag = true
        }
    }
}
