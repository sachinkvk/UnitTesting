//
//  LoginScreenViewController.swift
//  UnitTest
//
//  Created by Sachin Panigrahi on 17/05/19.
//  Copyright © 2019 Sachin Panigrahi. All rights reserved.
//

import UIKit


extension UILabel {
    var preInitilize : String {
        get {
            return "just awesome"
        }
        set(newVal) {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.text = newVal
        }
    }
}

class BaseLabel : UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(text : String) {
        super.init(frame: .zero)
        self.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LoginScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
