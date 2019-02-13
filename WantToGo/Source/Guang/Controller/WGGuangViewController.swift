//
//  GuangViewController.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/27.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

class WGGuangViewController: WGTableViewController {

    var headerView : WGGuangCatrgoryHeaderView?
    
    lazy var nav: UIView = { [weak self] in
        
        let textField = WGSearchTextField.init(frame: CGRect.init(x: 0, y: 0, width: kMainScreenWidth - 65, height: 35))
        textField.leftImageName = "icn_search_small"
        textField.rightImageName = "btn_qrcode"
        textField.placeholdString = "搜索好设计"
        textField.textColor = grayLineColor
        textField.textFont = font14
        textField.backgroundColor = .white
        
        return textField
        
        }()
    
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
                self.headerView?.selectItemBlock = { [weak self] (index: NSInteger) -> Void in
                    guard let strongSelf = self else {return}
                    
                    let item = strongSelf.headerView!.dataArray![index] as! WGGuangCatrgoryItem
                    
                    strongSelf.navigator.push(guangCategory+"/"+"\(item.id!)"+"/"+"\(item.name!)")
                    
                }
                self.tableView?.tableHeaderView = self.headerView
                
            }else{
                self.tableView?.tableHeaderView = nil
                self.headerView = nil
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.nav.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.nav.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = false
        self.initNavigationBar()
        
        //分类 数据
        self.loadCategoryData()
        //购物 数据
        self.loadShoppingBannerData()
        //精选 数据
        self.loadChoiceData()
        //大家喜欢 数据
        self.loadLovesData()
        
    }
    
    func initNavigationBar() -> Void {
        
        self.navigationController?.navigationBar.addSubview(self.nav)
        
        self.nav.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(35)
            make.right.equalToSuperview().offset(-50)
        }

        self.setNavigatonRightItem("icn_msg_white")
    }
    

    //MARK: --------- UITableViewDelegate,UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shoppingDataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "WGGuangShoppingBannerCell")
        
        if cell == nil {
            cell = WGGuangShoppingBannerCell.init(style: .default, reuseIdentifier: "WGGuangShoppingBannerCell")
        }
        
        if indexPath.row < self.shoppingDataArray.count {

            let model = self.shoppingDataArray.object(at: indexPath.row) as! WGGuangShopingContentModel

            (cell as! WGGuangShoppingBannerCell).loadData(model: model)
            (cell as! WGGuangShoppingBannerCell).scrollViewLoadMoreBlock = { [weak self] () in
                guard let strongSelf = self else {return}
                strongSelf.pushWebViewController(url: model.h5Url!)
                strongSelf.tableView?.reloadData()
            }
            
            (cell as! WGGuangShoppingBannerCell).selectItemsBlock = { [weak self] (_ type : SelectItemsType, _ index : NSInteger) in
                guard let strongSelf = self else {return}
                if index < 0 && type == .banner {
                    
                    strongSelf.pushWebViewController(url: model.h5Url!)
                }else{
                    if index < model.items!.count {
                        
                        let item = model.items?[index]
                        
                        strongSelf.navigator.push(commodityDetail+"/"+"\(item!.id!)")
                    }
                }
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row < self.shoppingDataArray.count {
            
            let model = self.shoppingDataArray.object(at: indexPath.row) as! WGGuangShopingContentModel
            (cell as! WGGuangShoppingBannerCell).itemDataArray = model.items! as NSArray
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 420
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

    
    func pushWebViewController(url : String?) -> Void {
        
        self.navigator.push(url!)
        
//        let webVC = WGWebViewController()
//        webVC.urlString = url
//        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    
    //MARK: --------- NetWork Data
    
    func loadCategoryData() -> Void {
        
        NetworkRequest(.guangCategoryApi(Dict: [:])) { (response) -> (Void) in
            
            if let categoryModel = WGGuangCategoryModel.deserialize(from: response){
                if categoryModel.code == SuccessCode {
                    self.categoryDataArray = categoryModel.data! as NSArray
                }
            }
        }
    }
    
    func loadShoppingBannerData() -> Void {
        
        NetworkRequest(.guangShoppingBannerApi(Dict: [:])) { (response) -> (Void) in
   
            if let shoppingBannarModel = WGGuangShopingModel.deserialize(from: response) {
                if shoppingBannarModel.code == SuccessCode {
                    let mainModel : WGGuangShopingMainModel = shoppingBannarModel.data!
                    self.shoppingDataArray = mainModel.content! as NSArray
                }
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



