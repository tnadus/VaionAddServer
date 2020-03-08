//
//  AddServerSuccessViewControllerTests.swift
//  VaionAddServerTests
//
//  Created by Murat Sudan on 8.03.2020.
//  Copyright © 2020 Tarum Nadus. All rights reserved.
//

import XCTest
@testable import VaionAddServer

class AddServerSuccessViewControllerTests: XCTestCase {
    
    func test_viewDidLoad_withTitleAndMessage_reflectsOnSubviews() {
        
        let addServerSuccessInfo = AddServerSuccessInfo(title: "title_here", message: "message_here")
        let sut = AddServerSuccessViewController(successInfo: addServerSuccessInfo)
        _ = sut.view
        
        XCTAssertEqual(sut.labelTitle.text, "title_here")
        XCTAssertEqual(sut.labelMessage.text, "message_here")
    }
}
