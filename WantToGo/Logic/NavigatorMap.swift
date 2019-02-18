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

        navigator.register(commodityDetail+"/<commodityid>"){ url, values, context in
            
            guard let commodityid = values["commodityid"] as? String else { return nil }
            return WGCommodityDetailController(navigator: navigator, commodityid: commodityid)
        }
        
        navigator.register(guangCategory+"/<categoryid>"+"/<categoryname>"){ url, values, context in
            
            guard let commodityid = values["categoryid"] as? String else { return nil }
            guard let categoryname = values["categoryname"] as? String else { return nil }
           
            return WGGuangCategoryController(navigator: navigator, categoryid: commodityid, categoryname: categoryname)
        }
        
        navigator.register(taDetail+"/<postid>"){ url, values, context in
            
            guard let postid = values["postid"] as? String else { return nil }
            
            return WGTaDetailViewController(navigator: navigator, postid: postid)
        }
        
        navigator.register(designerTagList+"/<tagid>"+"/<tagname>"){ url, values, context in
            
            guard let tagid = values["tagid"] as? String else { return nil }
            guard let tagname = values["tagname"] as? String else { return nil }
            return WGDesignerTagListController(navigator: navigator, tagid: tagid, tagname: tagname)
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


