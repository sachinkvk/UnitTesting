//
//  UIView+Layouts.swift
//  UnitTest
//
//  Created by Sachin Panigrahi on 22/05/19.
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
