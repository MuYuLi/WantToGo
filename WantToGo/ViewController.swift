//
//  ViewController.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/22.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var cardPageView : MYLCardPageView?
    var dataArray : NSArray? {
        didSet{
            let imgArray = NSMutableArray()
            for homeTopicItem in dataArray as! [HomeTopicItem] {
                imgArray.add(homeTopicItem.imageMin!)
            }
            self.cardPageView?.imageNameArray = imgArray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initMYLCardPageView()
        self.loadData()
        
    }
    func initMYLCardPageView() -> Void{
        
        self.cardPageView = MYLCardPageView.init(frame: self.view.bounds)
        self.view.addSubview(self.cardPageView!)
        self.cardPageView?.collectionViewRect = self.view.frame
        self.cardPageView?.backgroundColor = UIColor.black
    }

    func loadData() -> Void {
  
        let dict = NSMutableDictionary()
        let date = NSDate.timeIntervalSinceReferenceDate
        dict.setValue("专题", forKey: "key")
        dict.setValue(date, forKey: "t")
        NetworkRequest(.homePageTopicApi(Dict: dict as! [String : Any])){ (respose) -> (Void) in
            
            if let homeTopicModel = HomeTopicModel.deserialize(from: respose){
                self.dataArray = homeTopicModel.data! as NSArray
            }
        }
    }
}

