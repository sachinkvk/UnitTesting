//
//  MockViewController.swift
//  UnitTest
//
//  Created by Sachin Panigrahi on 24/05/19.
//  Copyright © 2019 Sachin Panigrahi. All rights reserved.
//

import UIKit

class MockViewController: UIViewController,UITableViewDataSource {
    var dataSource : [String] = ["A","B","C","D","A","B","C","D","A","B","C","D"]
    
    let myTableView : UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = .gray
        return tableview
    }()
    
    convenience init(dataSource : [String]) {
        self.init()
        self.dataSource = dataSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myTableView)
        
        myTableView.setAnchors(top: self.view.topAnchor, bottom: self.view.bottomAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, constant: UIEdgeInsets.init(top: 100, left: 0, bottom: 0, right: 0))
        myTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
}
