//
//  WGTaDetailModel.swift
//  WantToGo
//
//  Created by Muyuli on 2019/2/12.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit
import HandyJSON
class WGTaDetailModel: WGModel {

}


/// 内容
class WGTaDetailContentModel: WGModel {
    var data : WGTaDetailContentDataModel?
    required init() {
    }

}

class WGTaDetailContentDataModel: HandyJSON {
    var authorAvatarURL : String?
    var authorId : NSInteger?
    var authorName : String?
    var authorTag : String?
    var commentNum : NSInteger?
    var comments : Array<WGTaDetailContentDataItem>?
    
    var contents : Array<WGTaDetailContentDataItem>?
    
    var createAt : String?
    var id : NSInteger?
    var favorNum : NSInteger?
    var hasAttention : Bool?
    var hasFavor : Bool?
    var postTitle : String?
    var updateAt : String?
    var userId : NSInteger?
    var uvNum : NSInteger?
    
    
    required init() {
    }
    
}

class WGTaDetailContentDataItem: HandyJSON {
    
    var content : String?
    var frontCover : String?
    var imgWidth : NSInteger?
    var imgKey : String?
    var imgHeight : NSInteger?
    var type : NSInteger?
    
    required init() {
    }
}


/// 评论
class WGTaDetailCommontModel: WGModel {
    
    
    var data : Array<WGTaDetailCommontDataModel>?
    required init() {
    }

}

class WGTaDetailCommontDataModel: WGModel {
    
    var avaPath : String?
    var content : String?
    var description : String?
    var nick : String?
    var time : String?
    var userId : NSInteger?
    
    
    required init() {
    }
    
}


/// 喜欢
class WGTaDetailFavorsModel: WGModel {
        var data : Array<WGTaDetailFavorsDataModel>?
    required init() {
    }
}

class WGTaDetailFavorsDataModel: WGModel {
    var avaPath : String?
    var nickName : String?
    var hasFollow : Bool?
    var fansNum : NSInteger?
    var followNum : NSInteger?
    
    var userId : NSInteger?
    required init() {
    }
}
