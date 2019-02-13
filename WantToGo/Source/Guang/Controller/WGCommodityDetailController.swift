//
//  WGCommodityDetailController.swift
//  WantToGo
//
//  Created by Muyuli on 2019/1/25.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit
import URLNavigator

class WGCommodityDetailController: WGTableViewController {

    var commodityid : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
        
    }
    
    init(navigator: NavigatorType, commodityid: String) {
        self.commodityid = commodityid
        super.init(navigator: navigator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}
