//
//  WGTaDiscoverModel.swift
//  WantToGo
//
//  Created by Muyuli on 2018/12/3.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit
import HandyJSON

class WGTaDiscoverModel: WGModel {

    var data : Array<WGTaDiscoverDataModel>?
    required init() {
    }

}

class WGTaDiscoverDataModel: HandyJSON {
    
    var authorAvatarURL : String?
    var authorId : NSInteger?
    var authorName : String?
    var authorTag : String?
    var commentNum : NSInteger?
    
    var comments : Array<WGTaDiscoverCommentsItem>?
    var contents : Array<WGTaDiscoverContentsItem>?
    
    var createAt : String?
    var favorNum : NSInteger?
    var hasAttention : Bool?
    var hasFavor : Bool?
    var id : NSInteger?
    var postTitle : String?
    var share : String?
    var updateAt : String?
    var userId : NSInteger?
    var uvNum : String?
    
    
    required init() {
    }
    
}

class WGTaDiscoverCommentsItem: HandyJSON {
    
    var avaPath : String?
    var content : String?
    var description : String?
    var id : NSInteger?
    var images : NSArray?
    var nick : String?
    var towardId : NSInteger?
    var smallImages : NSArray?
    var time : String?
    var towardNick : String?
    var userId : NSInteger?
    
    required init() {
    }
    
}
class WGTaDiscoverContentsItem: HandyJSON {
    
    var content : String?
    var frontCover : Bool?
    var imgHeight : NSInteger?
    var imgKey : String?
    var imgWidth : NSInteger?
    var type : NSInteger?
    
    required init() {
    }
    
}
