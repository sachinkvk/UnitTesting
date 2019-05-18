//
//  UnitTestTests.swift
//  UnitTestTests
//
//  Created by Sachin Panigrahi on 17/05/19.
//  Copyright © 2019 Sachin Panigrahi. All rights reserved.
//

import XCTest
@testable import UnitTest

class UnitTestTests: XCTestCase {
    
    var vc = LoginScreenViewController()
    
    override func setUp() {
//        _ = vc.view
//        vc.loadView()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    class FakeAlert : UIAlertAction {
//        var alertTitle : String?
//        var alertStyle : UIAlertAction.Style?
//        var alertHandler : (UIAlertAction)->(Void)?
//
//        convenience init(title: String?, handler: ((UIAlertAction) -> Void)?, preferredStyle: UIAlertController.Style = .alert) {
//            self.init()
//            self.alertTitle = title
//            self.alertHandler = handler!
//        }
//
//        override init() {
//            self.alertStyle = UIAlertAction.Style.default
//            super.init()
//        }
//
//        required init?(coder aDecoder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
    }
    
    func testLoginScreenClickMeButton() {
        XCTAssertNotNil(vc)
        let button = vc.clickMeButtom
        XCTAssertNotNil(button)
        var msgStr = ""
        vc.handleClick()
        
    }
}
