//
//  WGGuangShopingModel.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/28.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit
import HandyJSON

class WGGuangShopingModel: WGModel {

    var data : WGGuangShopingMainModel?
    
    required init() {
    }
}


class WGGuangShopingMainModel : HandyJSON {
   
    var content : Array<WGGuangShopingContentModel>?
    var totalPages : NSInteger?
    var totalElements : NSInteger?
    var sort : Bool?
    var size : NSInteger?
    var numberOfElements : NSInteger?
    var number : NSInteger?
    var last : Bool?
    var first : Bool?
    
    required init() {
    }
}


class WGGuangShopingContentModel : HandyJSON {
    
    var description : String?
    var h5Url : String?
    var id : NSInteger?
    var image : String?
    var name : String?
    var title : String?
    var items : Array<WGGuangShopingItem>?
    
    required init() {
    }
}


class WGGuangShopingItem : HandyJSON {
    
    var brandName : String?
    var id : NSInteger?
    var image : String?
    var keyword : String?
    var originalPrice : Double?
    var price : Double?
    
    required init() {
    }
    
    
}
