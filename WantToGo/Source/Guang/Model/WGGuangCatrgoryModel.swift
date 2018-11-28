//
//  WGGuangCatrgoryModel.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/27.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit
import HandyJSON

class WGGuangCatrgoryModel: WGModel {

    
    var data : Array<WGGuangCatrgoryItem>?
    
    required init() {
    }
    
}


class WGGuangCatrgoryItem: HandyJSON {
    
    var allowPartition : Bool?
    var expression : String?
    var id : String?
    var logo : String?
    var name : String?
    var orderNum : String?
    var orderScript : String?
    var orderType : String?
    var parentId : NSNumber?
    var randomResult : Bool?
    var status : String?
    
    required init() {
    }
    
}


