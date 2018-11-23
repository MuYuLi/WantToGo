//
//  NetworkAPI.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/23.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import Foundation
import Moya

enum NetworkAPI {
    case testApiDict(Dict:[String:Any])//把参数包装成字典传入
    case testApi
    case testAPi(para1:String,para2:String)//普遍的写法
}

extension NetworkAPI : TargetType {
    var baseURL: URL {
        return URL.init(string: "dddd")!
    }
    
    var method: Moya.Method {
        switch self {
        case .testApi:
            return .get
        default:
            return .post
        }
    }
    
    //单元测试用
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .testApi:
            return .requestPlain
        case let .testAPi(para1, _):
            return .requestParameters(parameters: ["key":para1], encoding: URLEncoding.default)
        case let .testApiDict(dict)://所有参数当一个字典进来完事。
            //后台可以接收json字符串做参数时选这个
            return .requestParameters(parameters: dict, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/x-www-form-urlencoded"]
    }
    
    //MARK: --------- 所有的网络请求接口path
    
    var path: String {
        switch self {
        case .testApi: return "4/news/latest"
        case .testAPi(let para1, _):
            return "\(para1)/news/latest"
        case .testApiDict:
            return "4/news/latest"
            
            // default:
            // return "4/news/latest"
        }
    }
}
