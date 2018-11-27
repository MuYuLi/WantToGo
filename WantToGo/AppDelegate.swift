//
//  AppDelegate.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/22.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit
import CYLTabBarController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
  
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.backgroundColor = .white
        window.rootViewController = MainTabBarController(viewControllers: self.viewControllers(), tabBarItemsAttributes: self.tabBarItemsAttributesForController())
        self.window = window
        
        //tabbar背景色
        UITabBar.appearance().backgroundColor = UIColor.white
        //tabbar字体颜色
        UITabBar.appearance().tintColor = UIColor(r: 214, g: 164, b: 49)
        
        return true
    }

    func tabBarItemsAttributesForController() -> [[String : String]] {
        
        let tabBarItemTheme = [CYLTabBarItemTitle:"专题",
                               CYLTabBarItemImage:"tab_theme_nrl",
                               CYLTabBarItemSelectedImage:"tab_theme_hlt"]
        
        let tabBarItemDesiner = [CYLTabBarItemTitle:"设计师",
                                 CYLTabBarItemImage:"tab_designer_nrl",
                                 CYLTabBarItemSelectedImage:"tab_designer_hlt"]
        
        let tabBarItemTa = [CYLTabBarItemTitle:"TA说",
                            CYLTabBarItemImage:"tab_ta_nrl",
                            CYLTabBarItemSelectedImage:"tab_ta_hlt"]
        
        let tabBarItemGuang = [CYLTabBarItemTitle:"逛",
                               CYLTabBarItemImage:"tab_guang_nrl",
                               CYLTabBarItemSelectedImage:"tab_guang_hlt"]
        
        let tabBarItemProfile = [CYLTabBarItemTitle:"我的",
                                 CYLTabBarItemImage:"tab_profile_nrl",
                                 CYLTabBarItemSelectedImage:"tab_profile_hlt"]
        
        let tabBarItemsAttributes = [tabBarItemTheme,tabBarItemDesiner,tabBarItemTa,tabBarItemGuang,tabBarItemProfile]
        
        return tabBarItemsAttributes
    }
    
    func viewControllers() -> [UIViewController] {
        
        let theme = WGNavigationController(rootViewController: WGThemeViewController())
        let desiner = WGNavigationController(rootViewController: DesignerViewController())
        let ta = WGNavigationController(rootViewController: TaViewController())
        let guang = WGNavigationController(rootViewController: GuangViewController())
        let mine = WGNavigationController(rootViewController: MineViewController())
        
        let viewControllers = [theme, desiner, ta, guang, mine]
        return viewControllers
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

