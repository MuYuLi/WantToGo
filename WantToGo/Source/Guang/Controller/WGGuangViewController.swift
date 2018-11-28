//
//  GuangViewController.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/27.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

class WGGuangViewController: WGViewController,UITableViewDelegate,UITableViewDataSource {

    var headerView : WGGuangCatrgoryHeaderView?
    
    //content shopping数据源
    var shoppingDataArray = NSArray() {
        
        didSet{
            self.tableView?.reloadData()
        }
    }
    
    //顶部 category数据源
    var categoryDataArray : NSArray? {
        didSet{
            if categoryDataArray?.count ?? 0 > 0 {

                let itemWidth = kMainScreenWidth / 4
                self.headerView = WGGuangCatrgoryHeaderView.init(frame: CGRect.zero)
                self.headerView?.backgroundColor = UIColor.white
                self.headerView?.dataArray = categoryDataArray
                self.headerView?.frame.size.height = CGFloat((categoryDataArray!.count - 1 )/4) * itemWidth + itemWidth + 10
                self.headerView?.selectItemBlock = {(index: NSInteger) -> Void in

                    
                    
                }
                self.tableView?.tableHeaderView = self.headerView
                
            }else{
                self.tableView?.tableHeaderView = nil
                self.headerView = nil
            }
        }
    }
    
    var tableView : UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTableView()
        //分类 数据
        self.loadCategoryData()
        //购物 数据
        self.loadShoppingBannerData()
        //精选 数据
        self.loadChoiceData()
        //大家喜欢 数据
        self.loadLovesData()
        
    }
    
    func initTableView() -> Void {
        
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: CGFloat(STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT), width: kMainScreenWidth, height: IPHONE_CONTENT_HEIGHT), style: .plain)
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.view.addSubview(self.tableView!)
        
    }

    //MARK: --------- UITableViewDelegate,UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shoppingDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "WGGuangShoppingBannerCell")
        
        if cell == nil {
            cell = WGGuangShoppingBannerCell.init(style: .default, reuseIdentifier: "WGGuangShoppingBannerCell")
        }
        
        if indexPath.row < self.shoppingDataArray.count {
            
            let model = self.shoppingDataArray.object(at: indexPath.row) as! WGGuangShopingContentModel
       
            (cell as! WGGuangShoppingBannerCell).loadData(model: model)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footer = UIView()
//        footer.backgroundColor = UIColor.lightGray
//        return footer
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 10
//    }
//

    //MARK: --------- NetWork Data
    
    func loadCategoryData() -> Void {
        
        NetworkRequest(.guangCategoryApi(Dict: [:])) { (response) -> (Void) in
            
            if let catrgoryModel = WGGuangCatrgoryModel.deserialize(from: response){
                self.categoryDataArray = catrgoryModel.data! as NSArray
            }
        }
    }
    
    func loadShoppingBannerData() -> Void {
        
        NetworkRequest(.guangShoppingBannerApi(Dict: [:])) { (response) -> (Void) in
   
            if let shoppingBannarModel = WGGuangShopingModel.deserialize(from: response) {
                let mainModel : WGGuangShopingMainModel = shoppingBannarModel.data!
                self.shoppingDataArray = mainModel.content! as NSArray
            }
        }
    }
    
    func loadChoiceData() -> Void {
        
        let dict = NSMutableDictionary()
        dict.setValue("1", forKey: "page")
        NetworkRequest(.guangChoiceApi(Dict: dict as! [String : Any])) { (response) -> (Void) in
            
            
            
        }
    }
    
    func loadLovesData() -> Void {
        let dict = NSMutableDictionary()
        dict.setValue("1", forKey: "p")
        
        NetworkRequest(.guangLovesApi(Dict: dict as! [String : Any])) { (response) -> (Void) in
            
            
            
            
            
            
        }
    }
     
}



