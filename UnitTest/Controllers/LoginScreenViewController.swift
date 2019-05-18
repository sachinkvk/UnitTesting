//
//  LoginScreenViewController.swift
//  UnitTest
//
//  Created by Sachin Panigrahi on 17/05/19.
//  Copyright © 2019 Sachin Panigrahi. All rights reserved.
//

import UIKit

extension UIView {
    func setAnchors(top : NSLayoutYAxisAnchor? = nil,bottom: NSLayoutYAxisAnchor? = nil,leading: NSLayoutXAxisAnchor? = nil,trailing: NSLayoutXAxisAnchor? = nil,constant : UIEdgeInsets?) {
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: (constant?.top)!).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: (constant?.left)!).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: (constant?.right)!).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: (constant?.bottom)!).isActive = true
        }
    }
    
    func setAnchorPosition(horizontal : NSLayoutXAxisAnchor? = nil, vertical : NSLayoutYAxisAnchor? = nil){
        if let horizontal = horizontal {
            self.centerXAnchor.constraint(equalTo: horizontal).isActive = true
        }
        
        if let vertical = vertical {
            self.centerYAnchor.constraint(equalTo: vertical).isActive = true
        }
    }
    
    func setAnchorSize(size : CGSize) {
        if size.height != 0{
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        if size.width != 0{
            self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    }
}

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
    
    var simpleText = BaseLabel(text: "Hello world")
    var alert = UIAlertController(title: "Error", message: "enter name", preferredStyle: .alert)
    var actionString = ""
    let lbl : UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello world"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let fn : UITextField = {
        let tf  = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
//        tf.text = "Hello world"
        tf.placeholder = "enter first name"
        tf.font = .systemFont(ofSize: 18)
        return tf
    }()
    
    let clickMeButtom : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Clicked", for: .normal)
        button.setTitle("Not Clicked", for: .selected)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.blue, for: .selected)
        button.backgroundColor = UIColor.orange
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(LoginScreenViewController.handleClick), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        simpleText = BaseLabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
//        view.addSubview(simpleText)
        view.addSubview(clickMeButtom)
        view.addSubview(fn)
        
        view.addSubview(lbl)
        
        lbl.setAnchorPosition(horizontal: view.centerXAnchor, vertical: view.centerYAnchor)
        clickMeButtom.setAnchors(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, constant: UIEdgeInsets.init(top: 100, left: 100, bottom: 0, right: -100))
        fn.setAnchors(top: clickMeButtom.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, constant: UIEdgeInsets.init(top: 20, left: 40, bottom: 0, right: -40))
        
        clickMeButtom.setAnchorSize(size: CGSize.init(width: 0, height: 100))
    }
    
    @objc func handleClick() {
        if fn.text!.isEmpty {
            DispatchQueue.main.async {
                self.present(self.alert, animated: true) {
                }
            }
        }
    }
}
