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
    
    var presenter: AddServerPresenterMock!
    var sut: AddServerViewController!
    
    override func setUp() {
        super.setUp()
        presenter = AddServerPresenterMock()
        sut = createSUT()
    }
        
    func test_viewDidLoad_startsPresenter() {
        XCTAssertTrue(presenter.startCalledFlag)
    }
    
    func test_OKButton_setDisabled_emptyIPAddressLabel() {
        sut.textFieldIPAddress.text = ""
        XCTAssertEqual(sut.buttonOK.isEnabled, false)
    }
    
    func test_OKButton_withNonEmptyIPAddress_setEnabled() {
        sut.textFieldIPAddress.text = "127"
        sut.textFieldIPAddress.sendActions(for: .editingChanged)
        XCTAssertEqual(sut.buttonOK.isEnabled, true)
    }
    
    func test_OKButtonTapped_callsPresenterButtonTap() {        
        sut.onButtonOKTapped(sut.buttonOK as Any)
        XCTAssertEqual(presenter.buttonOKTappedCalledFlag, true)
    }

}

extension AddServerViewControllerTests {
    
    func createSUT() -> AddServerViewController {
        let sut = AddServerViewController(presenter: presenter)
        _ = sut.view
        return sut
    }
    
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
