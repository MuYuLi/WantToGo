//
//  WGConstants.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/27.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import Foundation
import UIKit


let kMainScreenWidth = UIScreen.main.bounds.size.width
let kMainScreenHeight = UIScreen.main.bounds.size.height

let IS_IPHONEX = SafeAreaInsets.top == 44 ? true : false
let STATUS_BAR_HEIGHT = (IS_IPHONEX ? 44 : 20)
let TAB_BAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height>20 ? 83:49
let NAV_BAR_HEIGHT = 44
let IPHONE_CONTENT_HEIGHT = kMainScreenHeight - CGFloat(NAV_BAR_HEIGHT + STATUS_BAR_HEIGHT + TAB_BAR_HEIGHT)

let safeAreaInsets = UIEdgeInsets(top: 44, left: 0, bottom: 34, right: 0)

//view.safeAreaInsets要在viewDidLoad之后调用才有正确的值，所以可以写一个全局常量，默认lazy属性，延时加载只赋值一次
//注意，常量只会赋值一次，竖屏调用后，转横屏，再调用值不会变
let SafeAreaInsets: UIEdgeInsets = {
    guard #available(iOS 11.0, *), let safeAreaInsets = UIApplication.shared.delegate?.window??.safeAreaInsets else {
        return UIEdgeInsets()
    }
    return safeAreaInsets
} ()



let KMainColor = UIColor(r: 214, g: 164, b: 49)

