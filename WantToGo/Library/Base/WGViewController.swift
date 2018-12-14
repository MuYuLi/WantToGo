//
//  WGViewController.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/22.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

class WGViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
    }
    
    /// 状态栏状态
    public var statusBarStyle : UIStatusBarStyle = .default {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    func setStatusBarBackground(color : UIColor) -> Void {
        let statusBar = (UIApplication.shared.value(forKey: "statusBarWindow") as! UIView).value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = color;
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarStyle
    }
}
