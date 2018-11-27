//
//  HomeTopicModel.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/24.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit
import HandyJSON

class HomeTopicModel: WGModel {
    
    var data : Array<HomeTopicItem>?

    required init() {
    }
}


class HomeTopicItem: HandyJSON {
    
    var flag : Bool?
    var id : NSString?
    var image : NSString?
    var imageMin : NSString?
    var imageType : NSString?
    var keyword : NSString?
    var name : NSString?
    var tagid : NSString?
    var type : NSNumber?
    var url : NSString?
    required init() {
    }
}
