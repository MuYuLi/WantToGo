//
//  ThemeAnimationImageView.swift
//  WantToGo
//
//  Created by Muyuli on 2018/12/8.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

class ThemeAnimationImageView: UIImageView {


    func showAnimation() -> Void {
        
        UIView.animate(withDuration: 2.0, animations: {
            self.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        }) { (true) in
            
            UIView.animate(withDuration: 2.0, animations: {
                self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            })
        }
    }
}
