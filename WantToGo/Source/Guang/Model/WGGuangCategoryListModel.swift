//
//  WGGuangCategoryListModel.swift
//  WantToGo
//
//  Created by Muyuli on 2019/2/11.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit
import HandyJSON



class WGGuangCategoryListModel: WGModel {
    
    
    var data : WGGuangCategoryDataListModel?
    

    required init() {
    }
    
}

class WGGuangCategoryDataListModel: HandyJSON {
    
    
    var records : Array<WGGuangCategoryDataListItem>?
    var isLasted : Bool?
    var page : String?
    var size : Bool?
    var total : String?
    
    required init() {
    }
    
}

class WGGuangCategoryDataListItem: HandyJSON {
    
    var avaPath : Bool?
    var brand : String?
    var commentNum : String?
    var description : String?
    var favNum : String?
    var hasFaver : String?
    var height : NSInteger?
    var image : String?
    var nickName : String?
    var originalPrice : String?
    var parentCategoryId : NSInteger?
    var picTagImages : Array<Any>?
    var price : Double?
    var productDescription : String?
    
    var productId : NSInteger?
    var time : String?
    var userId : NSInteger?
    var width : NSInteger?
    
    required init() {
    }
    
}


