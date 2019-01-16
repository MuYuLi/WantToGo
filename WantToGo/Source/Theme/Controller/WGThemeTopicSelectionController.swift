//
//  WGThemeTopicSelectionController.swift
//  WantToGo
//
//  Created by Muyuli on 2019/1/15.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit
import URLNavigator

class WGThemeTopicSelectionController: WGViewController {
    public var tagid : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "专题精选"
        
        self.loadData()
    }
    
    init(navigator: NavigatorType, context : HomeTopicItem?) {
        
        super.init(navigator: navigator)
        self.tagid = context?.id
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: --------- NetWork
   
    func loadData() -> Void {
        
        
    }
        
}
