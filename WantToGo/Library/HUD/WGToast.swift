//
//  WGToast.swift
//  WantToGo
//
//  Created by Muyuli on 2018/12/8.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit
import Toast


class WGToast: NSObject {
    
    class func showToast(title : String) -> Void {
        WGToast.showToast(title: title, position: CSToastPositionCenter)
    }
    
    class func showToast(title : String, position : Any) -> Void {
        WGToast.showToast(title: title, position: position, duration: 2.0)
    }
    
    class func showToast(title : String, position : Any, duration : TimeInterval) -> Void {
        
        UIApplication.shared.keyWindow?.makeToast(title, duration: duration, position: position, style: nil)
    }
    
}
