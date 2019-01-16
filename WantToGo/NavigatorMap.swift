//
//  NavigatorMap.swift
//  WantToGo
//
//  Created by Muyuli on 2018/12/22.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import Foundation
import URLNavigator
import UIKit

struct NavigatorMap {
    
    static func initialize(navigator: NavigatorType) {
        
        navigator.register(themeSelection) { url, values, context in
            
            return WGThemeTopicSelectionController(navigator: navigator, context:context as? HomeTopicItem)
        }

        navigator.register("wantgo://webView") { url, values, context in

            guard let urlStr = values["urlStr"] as? String else { return nil }
            return WGWebViewController.init(navigator: navigator, urlStr: urlStr)
        }

        navigator.register("http://<path:_>"){ url, values, context in
        
           return self.webViewControllerFactory(navigator: navigator, url: url, values: values, context: context)
        }
        
        navigator.register("https://<path:_>"){ url, values, context in
            
            return self.webViewControllerFactory(navigator: navigator, url: url, values: values, context: context)
        }
        
//        navigator.handle("navigator://alert", self.alert(navigator: navigator))
//        navigator.handle("navigator://<path:_>") { (url, values, context) -> Bool in
//            // No navigator match, do analytics or fallback function here
//            print("[Navigator] NavigationMap.\(#function):\(#line) - global fallback function is called")
//            return true
//        }
    }
    
    private static func webViewControllerFactory(navigator : NavigatorType,
        url: URLConvertible,
        values: [String: Any],
        context: Any?
        ) -> UIViewController? {
        guard let url = url.urlValue else { return nil }
        return WGWebViewController.init(navigator: navigator, urlStr: url.urlStringValue)
    }

    private static func alert(navigator: NavigatorType) -> URLOpenHandlerFactory {
        return { url, values, context in
            guard let title = url.queryParameters["title"] else { return false }
            let message = url.queryParameters["message"]
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            navigator.present(alertController)
            return true
        }
    }
}


