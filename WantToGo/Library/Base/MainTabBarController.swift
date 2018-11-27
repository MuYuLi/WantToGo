//
//  MainTabbarController.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/25.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit
import CYLTabBarController


class MainTabBarController: CYLTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
    }
}

extension MainTabBarController:UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        self.updateSelectionStatusIfNeeded(for: tabBarController, shouldSelect: viewController)
        return true
    }
    
}

