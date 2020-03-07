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
        
        let ipAddress = "127.0.0.1"
        sut.onOKButtonTapped(ipAddress: ipAddress)
        XCTAssertEqual(addServerUsecase.ipAddress, ipAddress)
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
        
        func addServer(ipAddress: String) {
            self.ipAddress = ipAddress
        }
    }
    
}
