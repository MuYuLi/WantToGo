//
//  Logic.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/24.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import Foundation
import Alamofire

class Logic {
    
    /// 用get方法是因为这样才会在获取isNetworkConnect时实时判断网络链接请求，如有更好的方法可以fork
    class func isNetworkConnect() -> Bool {
        
        let network = NetworkReachabilityManager()
        return network!.isReachable //无返回就默认网络已连接
    }
    

    
}










