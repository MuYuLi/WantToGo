//
//  WGNavigationController.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/25.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

class WGNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)){
       
            self.interactivePopGestureRecognizer?.delegate = nil
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //设置导航栏背景图片为一个空的image，这样就透明了
//        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //去掉透明后导航栏下边的黑边
//        self.navigationBar.shadowImage = UIImage()

        self.initNavigator()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //如果不想让其他页面的导航栏变为透明 需要重置
//        self.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
//        self.navigationBar.shadowImage = nil
    }

  
    func initNavigator() -> Void {
       
        //appearance方法返回一个导航栏的外观对象
        //修改了这个外观对象，相当于修改了整个项目中的外观
        let navigationBar = UINavigationBar.appearance()
        //设置导航栏背景颜色
        navigationBar.barTintColor = UIColor(r: 33, g: 33, b: 33)
        
        //设置NavigationBarItem文字的颜色
        navigationBar.tintColor = UIColor.white
        //修改item上面的文字样式
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize.zero
        //设置标题栏颜色
        let dict = [NSAttributedString.Key.foregroundColor : UIColor.white,
                    NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18),]
        
        navigationBar.titleTextAttributes = dict
        
        //修改所有UIBarButtonItem的外观
        let barButtonItem = UIBarButtonItem.appearance()
        // 修改item的背景图片
        // barButtonItem.setBackgroundImage(UIImage.init(named: ""), for: UIControl.State.normal, barMetrics: UIBarMetrics.default)
        
        //修改item上面的文字样式
        barButtonItem.setTitleTextAttributes(dict, for: UIControl.State.normal)
 
        //修改返回按钮样式
        barButtonItem.setBackButtonBackgroundImage(UIImage.init(named: "btn_back_b"), for:  UIControl.State.normal, barMetrics: UIBarMetrics.compact)
        
        //设置状态栏样式
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //修改返回文字

        //全部修改返回按钮,但是会失去右滑返回的手势
        if viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count >= 1 {
            viewController.navigationItem.leftBarButtonItem = self.creatBackButton()
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    func creatBackButton() -> UIBarButtonItem {
        return UIBarButtonItem.init(image: UIImage.init(named: "btn_back_b"), landscapeImagePhone: nil, style: UIBarButtonItem.Style.plain, target: self, action: #selector(popSelf))
    }
    
    @objc func popSelf() -> Void {
        self.popViewController(animated: true)
    }
    
}
