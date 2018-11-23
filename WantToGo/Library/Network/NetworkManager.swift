//
//  NetworkManager.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/23.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import Foundation
import Moya
import Alamofire

/// 成功回调
typealias successCallback = ((String) -> (Void))
/// 超时时长
private var requestTimeOut : Double = 30
///失败的回调
typealias failedCallback = ((String) -> (Void))
///网络错误的回调
typealias errorCallback = (() -> (Void))


private let myEndpointClosure = {(target : NetworkAPI) -> Endpoint in

    let url = target.baseURL.absoluteString + target.path
    var endpoint = Endpoint(
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers
        
    )
    switch target {
    case .testApi:
        return endpoint
    case .testApiDict:
        requestTimeOut = 5//按照项目需求针对单个API设置不同的超时时长
        return endpoint
    default:
        requestTimeOut = 30//设置默认的超时时长
        return endpoint
    }

}

private let requestClosure = {(endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    
    do{
        var request = try endpoint.urlRequest()
        request.timeoutInterval = requestTimeOut
        if let requestData = request.httpBody {
            print("\(request.url!)"+"\n"+"\(request.httpMethod ?? "")"+"发送参数"+"\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")") }
        else{
            print("\(request.url!)"+"\(String(describing: request.httpMethod))")
        }
        done(.success(request))
        
    } catch {
        done(.failure(MoyaError.underlying(error,nil)))
    }
    
}


private let networkPlugin = NetworkActivityPlugin.init { (changeType, targetType) in
    print("networkPlugin \(changeType)")
    
    switch (changeType) {
        
    case .began:
        print("开始请求网络")
        
    case .ended:
        print("结束")
    }
}

let Provider = MoyaProvider<NetworkAPI>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: [networkPlugin], trackInflights: false)


//MARK: --------- 继续封装

//要理解@escaping,首先需要理解closure, 要理解closure,首先理解匿名函数。
func NetworkRequest(_ target : NetworkAPI, completion: @escaping successCallback){
    
    Provider.request(target) {(result) in
        
        switch result{
        case let .success(response):
    
            do {
                completion(String(data: response.data, encoding: String.Encoding.utf8)!)
            } catch {
                
            }
        case let .failure(error):
            
            guard let error = error as? CustomStringConvertible else {
                print("网络连接失败")
                break
            }
        }
    }
}


