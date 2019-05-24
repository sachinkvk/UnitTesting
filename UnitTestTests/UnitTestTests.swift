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
    
//    var vc = LoginScreenViewController()
    var sut : TestViewController!
    
    override func setUp() {
        
        let storyboard = UIStoryboard(name: "Test", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "TestViewController") as? TestViewController
        _ = sut.view
    }
    
    func testVCObj() {
        XCTAssertNotNil(sut)
    }
    
    func testTable() {
        XCTAssertNotNil(sut.myTableView)
    }
    
    func testTableViewAppear() {
        XCTAssertEqual(sut.myTableView.isHidden,false)
    }
    
    func testTableWithZeroRows(){
        sut.dataSource = []
        
        XCTAssertEqual(sut.myTableView.numberOfRows(inSection: 0), 0)
    }
    
    func testTableViewRowsCount(){
        let source = ["A","B"]
        sut.dataSource = source
        sut.myTableView.reloadData()
        XCTAssertEqual(sut.myTableView.numberOfRows(inSection: 0), 2)
    }
    
    func testTableViewCell() {
        let source = ["A","B","C","D","A","B","C","D","A","B","C","D"]
        sut.dataSource = source
        sut.myTableView.reloadData()
        var ctr = 0
        sut.dataSource.forEach { (value) in
            let cell = sut.myTableView.dataSource?.tableView(sut.myTableView, cellForRowAt: IndexPath(row: ctr, section: 0))
            XCTAssertEqual(cell?.textLabel?.text, value)
            ctr += 1
        }
    }
    
    func testTableViewDidTap() {
        let source = ["A","B","C","D","A","B","C","D","A","B","C","D"]
        sut.dataSource = source
        sut.myTableView.reloadData()
        sut.myTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
        let indexPath = sut.myTableView.indexPathForSelectedRow
        XCTAssertEqual(source[(indexPath?.row)!], "A")
    }
    
    func testForNoRecord() {
        let source = ["A","B","C","D","A","B","C","D","A","B","C","D"]
        sut.dataSource = source
        sut.loadData()
        XCTAssertEqual(sut.noDataLabel.isHidden, true)
        
        sut.dataSource = []
        sut.loadData()
        XCTAssertEqual(sut.noDataLabel.isHidden, false)
    }
    
    func testMockViewController() {
        let sut = MockViewController(dataSource: [])
        _ = sut.view
        
        XCTAssertNotNil(sut)
    }
    
    func testTableView() {
        let sut = MockViewController(dataSource: ["A","B","C","D","A","B","C","D","A","B","C","D"])
        _ = sut.view
        var ctr = 0
        sut.dataSource.forEach { (value) in
            let cell = sut.myTableView.dataSource?.tableView(sut.myTableView, cellForRowAt: IndexPath(row: ctr, section: 0))
            XCTAssertEqual(cell?.textLabel?.text, value)
            ctr += 1
        }
    }
    
    
//    func makeTestVC(_ dataSource : [String]) -> TestViewController {
//
//    }

}
