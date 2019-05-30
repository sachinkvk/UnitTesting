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
    
    var simpleText = BaseLabel(text: "Hello world")
    var alert = UIAlertController(title: "Error", message: "enter name", preferredStyle: .alert)
    var actionString = ""
    let lbl : UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = UIColor(white: 1, alpha: 0.2)
        label.text = " Hello world He Hello world He Hello world He Hello world He"
        label.font = .systemFont(ofSize: 24)
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
    
    var firstView : UIView = {
        let view  = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    let secondView : UIView = {
        let view  = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    let thirdView : UIView = {
        let view  = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    let demoTableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let clickMeButtom : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Clicked", for: .normal)
        button.setTitle("Not Clicked", for: .selected)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.blue, for: .selected)
        button.backgroundColor = UIColor.lightGray
//        button.alpha = 0.80
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(LoginScreenViewController.handleClick), for: .touchUpInside)
        return button
    }()
    
    let clickMeButtom1 : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.blue, for: .selected)
        button.backgroundColor = UIColor.lightGray
        //        button.alpha = 0.80
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(LoginScreenViewController.handleClick), for: .touchUpInside)
        return button
    }()
    
    let clickMeButtom2 : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
         button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.blue, for: .selected)
        button.backgroundColor = UIColor.lightGray
        //        button.alpha = 0.80
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(LoginScreenViewController.handleClick), for: .touchUpInside)
        return button
    }()
    
    var isOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vm = SamppleViewModel()
        
        vm.fetchList { [weak self] (result) in
            switch result {
            case .success(let assignments) :
                print(assignments)
            case .failure(let err):
                print(err)
            }
        }
        
        view.backgroundColor = .white
        
        simpleText = BaseLabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
//        view.addSubview(simpleText)
        view.addSubview(clickMeButtom)
//        view.addSubview(clickMeButtom1)
//        view.addSubview(clickMeButtom2)
        
//        view.addSubview(fn)
        
//        view.addSubview(lbl)
        
//        view.addSubview(firstView)
//        view.addSubview(secondView)
//        view.addSubview(thirdView)

//        firstView.setAnchors(top: self.view.topAnchor, bottom: nil, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, constant: UIEdgeInsets.init(top: 20, left: 20, bottom: -20, right: -20))
//        firstView.setAnchorSize(size: CGSize.init(width: 0, height: 200))
//
//        secondView.setAnchors(top: self.firstView.bottomAnchor, bottom: nil, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, constant: UIEdgeInsets.init(top: 20, left: 20, bottom: 0, right: -20))
//        secondView.setAnchorSize(size: CGSize.init(width: 0, height: 200))
//
//        thirdView.setAnchors(top: self.secondView.bottomAnchor, bottom: nil, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, constant: UIEdgeInsets.init(top: 20, left: 20, bottom: 0, right: -20))
//        thirdView.setAnchorSize(size: CGSize.init(width: 0, height: 200))
        
//        lbl.setAnchorPosition(horizontal: view.centerXAnchor, vertical: view.centerYAnchor)
////        fn.setAnchors(top: clickMeButtom.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, constant: UIEdgeInsets.init(top: 20, left: 40, bottom: 0, right: -40))

        clickMeButtom.setAnchors(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, constant: UIEdgeInsets.init(top: 100, left: 20, bottom: 0, right: -20))

        clickMeButtom.setAnchorSize(size: CGSize.init(width: 0, height: 150))

//        clickMeButtom1.setAnchors(top: clickMeButtom.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, constant: UIEdgeInsets.init(top: 10, left: 20, bottom: 0, right: -100))
//        clickMeButtom1.setAnchorSize(size: CGSize.init(width: 0, height: 150))

//        clickMeButtom2.setAnchors(top: clickMeButtom1.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, constant: UIEdgeInsets.init(top: 10, left: 20, bottom: 0, right: -20))
//        clickMeButtom2.setAnchorSize(size: CGSize.init(width: 0, height: 180))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        startAnimation(self.view)
    }
    
    @objc func handleClick() {
        if isOpen {
            self.isOpen = false
            self.clickMeButtom.backgroundColor = .lightGray
            UIView.transition(with: self.clickMeButtom, duration: 1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
//            UIView.transition(from: self.clickMeButtom, to: self.clickMeButtom, duration: 1, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        } else {
            self.isOpen = true
                        UIView.transition(with: self.clickMeButtom, duration: 1, options: .transitionFlipFromRight, animations: nil, completion: nil)
            
//            UIView.transition(from: self.clickMeButtom, to: self.clickMeButtom, duration: 1, options: [.showHideTransitionViews,.transitionFlipFromRight], completion: nil)
            self.clickMeButtom.backgroundColor = .cyan
        }
        
//        startAnimation(self.view)
    }
}

extension UIViewController {
    func startAnimation(_ view : UIView) {
        
        view.subviews.forEach { (eachSubview) in
            let colorLayer = CALayer()
            colorLayer.backgroundColor = UIColor.lightGray.cgColor
            colorLayer.frame = CGRect(x: 0, y: 0, width: eachSubview.bounds.width, height: eachSubview.bounds.height)
            eachSubview.layer.addSublayer(colorLayer)
            eachSubview.autoresizesSubviews = true
            eachSubview.clipsToBounds = true
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.clear.cgColor,UIColor.lightGray.cgColor,UIColor.clear.cgColor,]
            gradientLayer.locations = [0, 1]
            gradientLayer.startPoint = CGPoint(x: 0, y: 1)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1)
            gradientLayer.frame = CGRect(x: 0, y: 0, width: eachSubview.bounds.width, height: eachSubview.bounds.height)
            eachSubview.layer.addSublayer(gradientLayer)
            
            let animation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.duration = 1.2
            animation.fromValue = -view.frame.width
            animation.toValue = view.frame.width
            animation.repeatCount = Float.infinity
            gradientLayer.add(animation, forKey: "")
        }
    }
}
