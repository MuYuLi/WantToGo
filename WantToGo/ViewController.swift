//
//  ViewController.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/22.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initMYLCardPageView()
        self.loadData()
        
    }
    func initMYLCardPageView() -> Void{
        
        let cardPageView = MYLCardPageView.init(frame: self.view.bounds)
        self.view.addSubview(cardPageView)
        
        cardPageView.collectionViewRect = self.view.frame
            
//            CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 100)
        cardPageView.backgroundColor = UIColor.black
        cardPageView.imageNameArray = ["1","2","3","4","5"]
    
    }

    
    func loadData() -> Void {
        
        Provider.request(.testApi){ (result) in
            
            switch result{
            case let .success(response):
                print(response)
            case let .failure(error):
                print(error)
                
            }
        }
        
        NetworkRequest(.testApi){ (respose) -> (Void) in
            
            
            
            
            
        }
        
        
    }
}

