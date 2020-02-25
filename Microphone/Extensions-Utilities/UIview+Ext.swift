//
//  UIview+Ext.swift
//  Microphone
//
//  Created by Jennifer Mah on 2/17/20.
//  Copyright © 2020 Jennifer Mah. All rights reserved.
//

import UIKit
//Constraints
extension UIView{
    func pin(to superView:UIView){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
}
