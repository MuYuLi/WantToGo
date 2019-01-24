//
//  WGThemeViewController.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/26.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

class WGThemeViewController: WGViewController {

    var showAnimationImageView : UIImageView?
    
    var titleView : UIImageView?
    var themeSelectImageAnimationView : WGThemeSelectImageAnimationView?
    var cardPageView : MYLCardPageView?
    var dataArray : NSArray? {
        didSet{
            let imgArray = NSMutableArray()
            for homeTopicItem in dataArray as! [HomeTopicItem] {
                imgArray.add(homeTopicItem.imageMin!)
            }
            self.cardPageView?.imageNameArray = imgArray
            let imageName = imgArray.firstObject as! String
            self.doSelectImageAnimation(imageName)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.barStyle = .black
        self.statusBarStyle = .default
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        super.viewWillDisappear(animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = false
        self.navigationItem.title = "专题"
    
        self.initMYLCardPageView()
        self.initTitleView()
        self.loadData()
        
    }
    
    //MARK: --------- Init
   
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
        self.cardPageView?.selectItemBlock = { [weak self] (index: NSInteger,currentImageVFrame : CGRect) -> Void in
            guard let strongSelf = self else {return}
            strongSelf.selectPageItem(index, currentImageVFrame)
        }
    }
    
    
    //MARK: --------- NetWork
    
    func loadData() -> Void {
        
        let dict = NSMutableDictionary()
        let date = NSDate.timeIntervalSinceReferenceDate
        dict.setValue("topic", forKey: "key")
        dict.setValue(date, forKey: "t")
        NetworkRequest(.themePageTopicApi(Dict: dict as! [String : Any])){ (respose) -> (Void) in
            
            if let homeTopicModel = HomeTopicModel.deserialize(from: respose){
                if homeTopicModel.code == SuccessCode {
                    self.dataArray = homeTopicModel.data! as NSArray
                }
            }
        }
    }
    
    //MARK: --------- Private Method
    
    func selectPageItem(_ index: NSInteger, _ contentImageVFrame : CGRect) -> Void {
        if index < (self.dataArray?.count)! {
            
            let homeTopicItem = self.dataArray?.object(at: index) as! HomeTopicItem
            if homeTopicItem.url != nil && homeTopicItem.type == 1 {
                let isPushed = self.navigator.push(homeTopicItem.url! as String) != nil
                if isPushed {
                    
                } else {
                    self.navigator.open(homeTopicItem.url! as String)
                }
            }else{
                
                self.themeSelectImageAnimationView = WGThemeSelectImageAnimationView.init(currentFrame: contentImageVFrame, resultsFrame: CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: kMainScreenHeight), imageName: homeTopicItem.imageMin!, parentViewController: self)
                self.themeSelectImageAnimationView?.themeSelectImageView?.scrollviewToLastPageBlock = { [weak self] () -> Void in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.navigator.push(themeSelection, context: homeTopicItem)
                    
                    strongSelf.themeSelectImageAnimationView?.dismissAnimation()
                    strongSelf.themeSelectImageAnimationView = nil
                }
                self.themeSelectImageAnimationView?.showEnlargeImageAnimation()
                
            }
        }
    }
    
    func doSelectImageAnimation(_ imageName: String) -> Void {
        
        let currentFrame = CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: kMainScreenHeight)
        let resultsFrame = CGRect.init(x: 30, y: CGFloat(STATUS_BAR_HEIGHT+NAV_BAR_HEIGHT), width: kMainScreenWidth - 60, height: (kMainScreenWidth - 60)/0.618)
        
        self.showAnimationImageView = UIImageView.init(frame: currentFrame)
        self.showAnimationImageView?.kf.setImage(with: URL(string: imageName))
        let rootVC = UIApplication.shared.delegate as! AppDelegate
        rootVC.window?.addSubview(self.showAnimationImageView!)
        
        UIView.animate(withDuration: 1.0, animations: {
            self.showAnimationImageView?.frame = resultsFrame
        }) { (true) in
            
            self.showAnimationImageView?.isHidden = true
            
            self.showAnimationImageView?.removeFromSuperview()
            self.showAnimationImageView = nil
        }
    }
}
