//
//  WGThemeSelectController.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/27.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

import URLNavigator

class WGThemeSelectController: WGViewController {
    
    public var tagid : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadData()
    }
    
    
    func loadData() -> Void {
        
        let dict = NSMutableDictionary()
        let date = NSDate.timeIntervalSinceReferenceDate
        dict.setValue(date, forKey: "t")
        dict.setValue(self.tagid, forKey: "tagid")
        
        NetworkRequest(.themeSearchListApi(Dict: dict as! [String : Any])) { (response) -> (Void) in
            
            
            
            
            
        }
    }
}
