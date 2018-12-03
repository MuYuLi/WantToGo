//
//  DesignerViewController.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/27.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

class WGDesignerViewController: WGTableViewController {

    let headerViewHeight : CGFloat = 200
    var selectIndex : NSInteger = 0
    
    var headerView : WGDesignerHeaderView?
    var sectionHeadV : WGDesingerSectionHeaderView?
    
    var recommendDataModel : WGDesignerRecommendDataModel?{
        didSet {
            
            self.headerView = WGDesignerHeaderView.init(frame: CGRect.zero)
            self.headerView?.loadUI(model: recommendDataModel!)
            self.headerView?.frame = self.tableView!.bounds
            self.headerView?.frame.size.height = headerViewHeight
            self.tableView?.tableHeaderView = self.headerView
        }
    }
    
    var tagsModelArray : NSArray?{
        didSet {
            self.tableView?.reloadData()
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
        self.tableView?.frame = CGRect.init(x: 0, y: CGFloat(-STATUS_BAR_HEIGHT), width: kMainScreenWidth, height: kMainScreenHeight - CGFloat(TAB_BAR_HEIGHT-STATUS_BAR_HEIGHT))
        
        self.loadTagsData()
        self.loadRecommendData()
    
        self.sectionHeadV = WGDesingerSectionHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: 50))
        self.sectionHeadV?.selectItemBlock = {(_ index:NSInteger) in
            self.selectIndex = index
            self.tableView?.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numRow : NSInteger = 0
        if self.tagsModelArray?.count ?? 0 > self.selectIndex {
            
            let tagDataModel = self.tagsModelArray?.object(at: self.selectIndex) as! WGDesignerTagsDataModel
            
            if tagDataModel.tags!.count > 0 {
                numRow = (tagDataModel.tags!.count + 1) / 2
            }
        }
        return numRow
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "WGDesingerTagCell")
        if cell == nil {
            cell = WGDesingerTagCell.init(style: .default, reuseIdentifier: "WGDesingerTagCell")
        }
        
        if self.tagsModelArray?.count ?? 0 > self.selectIndex {
            let tagDataModel = self.tagsModelArray?.object(at: self.selectIndex) as! WGDesignerTagsDataModel
            if tagDataModel.tags!.count > 0 {
                let tagArray = tagDataModel.tags! as NSArray
                var leftTagsItem : WGDesignerTagsItem? = nil
                var rightTagsItem : WGDesignerTagsItem? = nil
                
                if indexPath.row*2 < tagArray.count {
                    leftTagsItem = tagArray.object(at: indexPath.row*2) as? WGDesignerTagsItem
                }
                if indexPath.row*2+1 < tagArray.count {
                    rightTagsItem = tagArray.object(at: indexPath.row*2+1) as? WGDesignerTagsItem
                }
                (cell as! WGDesingerTagCell).loadUI(leftModel: leftTagsItem!, rightModel: rightTagsItem!)
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.sectionHeadV
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let yOffset : CGFloat = scrollView.contentOffset.y
        // 下拉 纵向偏移量变小 变成负的
        if yOffset < 0 {
            // 拉伸后图片的高度
            let totalOffset = self.headerViewHeight - yOffset;
            // 图片放大比例
            let scale = totalOffset / self.headerViewHeight;
            // 拉伸后图片位置
            self.headerView?.contentImageV!.frame = CGRect.init(x: -(kMainScreenWidth * scale - kMainScreenWidth) / 2, y: yOffset, width: kMainScreenWidth * scale, height: totalOffset)
            self.headerView?.maskBackView?.frame = self.headerView!.contentImageV!.frame
        }
    }
    
    //MARK: --------- NetWorkData
    
    func loadRecommendData() -> Void{
        let dict = NSMutableDictionary()
        NetworkRequest(.designerRecommendApi(Dict: dict as! [String : Any])){ (respose) -> (Void) in
            
            if let tagsModel = WGDesignerTagsModel.deserialize(from: respose){
                if tagsModel.code == SuccessCode {
                    self.tagsModelArray = tagsModel.data! as NSArray
                }
            }
        }
    }
    
    func loadTagsData() -> Void{
        
        let dict = NSMutableDictionary()
        NetworkRequest(.designerTagsApi(Dict: dict as! [String : Any])){ (respose) -> (Void) in
            
            if let recommendModel = WGDesignerRecommendModel.deserialize(from: respose){
                if recommendModel.code == SuccessCode {
                    self.recommendDataModel = recommendModel.data! as WGDesignerRecommendDataModel
                }else{
                }
            }
        }
    }
}
