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
    var id : String?
    var image : String?
    var imageMin : String?
    var imageType : String?
    var keyword :String?
    var name : String?
    var tagid : String?
    var type : NSNumber?
    var url : String?
    required init() {
    }
}
