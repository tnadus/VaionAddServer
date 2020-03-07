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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_start_withOnViewDidLoad_updatesView() {
        let managedView = AddServerViewControllerMock()
        let sut = AddServerPresenter()
        sut.managedView = managedView
        sut.start()
        XCTAssertEqual(managedView.updateViewCalledFlag, true)
    }

}

//MARK: Helpers
extension AddServerPresenterTests {
    
    class AddServerViewControllerMock: AddServerViewProtocol {
        
        var updateViewCalledFlag: Bool = false
        
        func updateView() {
            updateViewCalledFlag = true
        }
        
    }
    
}
