//
//  UIImage+Color.swift
//  WantToGo
//
//  Created by Muyuli on 2018/12/5.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {
    
    class func initImage(color : UIColor) -> UIImage {
        
        var image = UIImage()
        if let ctx = UIGraphicsGetCurrentContext() {
            let rect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
            ctx.setFillColor(color.cgColor)
            ctx.setStrokeColor(color.cgColor)
            ctx.addRect(rect)
            ctx.drawPath(using: .fillStroke)
            image = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }
        
        return image
    }
}

