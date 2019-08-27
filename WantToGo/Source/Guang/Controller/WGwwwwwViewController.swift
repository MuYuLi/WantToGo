//
//  WGwwwwwViewController.swift
//  WantToGo
//
//  Created by Muyuli on 2019/8/27.
//  Copyright © 2019 Muyuli. All rights reserved.
//

import UIKit

typealias SelectItemsClosures = (_ type : NSString, _ index : NSInteger) -> Void

class ViewController: UIViewController {
    
    let theBigThree = ["Jason","Jaylen","Gordon"]
    var headerView : UIView?
   
    var selectItemsClosures : SelectItemsClosures?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadUI()
    }

    func loadUI() -> Void {
        
    }
}
