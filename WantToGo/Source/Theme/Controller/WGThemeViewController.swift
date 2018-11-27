//
//  WGThemeViewController.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/26.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

class WGThemeViewController: WGViewController {

    var titleView : UIImageView?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        super.viewWillDisappear(animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "专题"
      
        self.initMYLCardPageView()
        self.initTitleView()
        self.loadData()
    
    }
    
    func initTitleView() -> Void {
        
        self.titleView = UIImageView.init(frame: CGRect.init(x: Int(kMainScreenWidth - 230) / 2 , y: STATUS_BAR_HEIGHT, width:230 , height: 30))
        self.titleView?.image = UIImage.init(named: "theme_title")
        self.view.addSubview(self.titleView!)
        
    }
    
    func initMYLCardPageView() -> Void{
        let frame = CGRect.init(x: 0, y: CGFloat(NAV_BAR_HEIGHT+STATUS_BAR_HEIGHT), width: kMainScreenWidth, height: IPHONE_CONTENT_HEIGHT)
        
        self.cardPageView = MYLCardPageView.init(frame: frame)
        self.view.addSubview(self.cardPageView!)
        self.cardPageView?.backgroundColor = UIColor.black
        self.cardPageView?.selectItemBlock = {(index: NSInteger) -> Void in
            self.selectPageItem(index: index)
        }
    }
    
    func loadData() -> Void {
        
        let dict = NSMutableDictionary()
        let date = NSDate.timeIntervalSinceReferenceDate
        dict.setValue("专题", forKey: "key")
        dict.setValue(date, forKey: "t")
        NetworkRequest(.themePageTopicApi(Dict: dict as! [String : Any])){ (respose) -> (Void) in
            
            if let homeTopicModel = HomeTopicModel.deserialize(from: respose){
                self.dataArray = homeTopicModel.data! as NSArray
            }
        }
    }
    func selectPageItem(index: NSInteger) -> Void {
        if index < (self.dataArray?.count)! {
            
            let homeTopicItem = self.dataArray?.object(at: index) as! HomeTopicItem
            if homeTopicItem.url != nil {
                
                let webVC = WGWebViewController()
                webVC.urlString = homeTopicItem.url
                self.navigationController?.pushViewController(webVC, animated: true)
                
            }
        }
    }
}
