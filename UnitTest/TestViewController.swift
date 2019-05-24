//
//  TestViewController.swift
//  UnitTest
//
//  Created by Sachin Panigrahi on 24/05/19.
//  Copyright © 2019 Sachin Panigrahi. All rights reserved.
//

import UIKit

class TestViewController: UIViewController,UITableViewDataSource {

    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    var dataSource : [String] = ["A","B","C","D","A","B","C","D","A","B","C","D"]
    
    convenience init(dataSource : [String]) {
        self.init()
        self.dataSource = dataSource
    }
    
    func loadData() {
        if dataSource.count > 0 {
            self.noDataLabel.isHidden = true
            self.myTableView.reloadData()
        } else {
            self.myTableView.isHidden = true
            self.noDataLabel.isHidden = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        noDataLabel.isHidden = true
        loadData()
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
