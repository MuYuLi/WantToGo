//
//  WGTaDetailViewController.swift
//  WantToGo
//
//  Created by Muyuli on 2019/2/12.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit
import URLNavigator

class WGTaDetailViewController: WGTableViewController {

    var postId : String?
    
    var contentModel : WGTaDetailContentDataModel? {
        didSet {
            self.tableView?.reloadData()
        }
    }
    var favorsArray : Array<WGTaDetailFavorsDataModel>? {
        didSet {
            self.tableView?.reloadData()
        }
    }
    var commentsArray : Array<WGTaDetailCommontDataModel>? {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "xuxix"
        self.view.backgroundColor = KBackgroudColor
        self.tableView?.backgroundColor = KBackgroudColor

        self.tableView?.frame = CGRect.init(x: 0, y: CGFloat(STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT), width: kMainScreenWidth, height: kMainScreenHeight-CGFloat(NAV_BAR_HEIGHT+STATUS_BAR_HEIGHT))
        
        self.tableView?.register(WGTaDetailAuthorViewCell.self, forCellReuseIdentifier: "WGTaDetailAuthorViewCell")
        self.tableView?.register(WGTaDetailContentLabelCell.self, forCellReuseIdentifier: "WGTaDetailContentLabelCell")
        self.tableView?.register(WGTaDetailContentImageViewCell.self, forCellReuseIdentifier: "WGTaDetailContentImageViewCell")
        self.tableView?.register(WGTaDetailCommontCell.self, forCellReuseIdentifier: "WGTaDetailCommontCell")
        self.tableView?.register(WGTaDetailFavorsCell.self, forCellReuseIdentifier: "WGTaDetailFavorsCell")

        
        self.loadContentData()//detail
        self.loadCommentData()//评论
        self.loadFavorsData()//喜欢
    }
    
    
    init(navigator: NavigatorType, postid: String) {
        self.postId = postid
        super.init(navigator: navigator)
        self.style = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            if (self.contentModel != nil) {
                return 1
            }else {
                return 0
            }
            
        }else if section == 1{
            return self.contentModel?.contents?.count ?? 0
        }else if section == 2 {
            
            if self.favorsArray?.count ?? 0 > 0 {
                return 1
            }
        }else if section == 3 {
            return self.commentsArray?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 1 {
            
            let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: 60))
            footerView.backgroundColor = .white
            
            let numLabel = UILabel.createLabel(frame: CGRect.init(x: 15, y: 0, width: 200, height: footerView.height), text: "浏览 "+"\(self.contentModel?.uvNum ?? 0)", textColor: grayColor, font: font12)
            numLabel.textAlignment = .left
            footerView.addSubview(numLabel)
            let timeLabel = UILabel.createLabel(frame: CGRect.init(x: kMainScreenWidth - 100, y: 0, width: 100, height: footerView.height), text: self.contentModel?.createAt ?? "", textColor: grayColor, font: font12)
            footerView.addSubview(timeLabel)
            
            let line = UIView.init(frame: CGRect.init(x: 15, y: footerView.height-1, width: kMainScreenWidth-15, height: 1))
            line.backgroundColor = grayLineColor
            footerView.addSubview(line)
            return footerView
            
        }else if section == 2 {
            if self.favorsArray?.isEmpty == true {//没有
                let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: 60))
                footerView.backgroundColor = .white
                
                let numLabel = UILabel.createLabel(frame: CGRect.init(x: 15, y: 0, width: 200, height: footerView.height), text: "暂时没有喜欢", textColor: grayColor, font: font12)
                numLabel.textAlignment = .left
                footerView.addSubview(numLabel)
                return footerView
            }
        }else if section == 3 {
            if self.commentsArray?.isEmpty == true {//没有
                let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: 60))
                footerView.backgroundColor = .white
                
                let numLabel = UILabel.createLabel(frame: CGRect.init(x: 15, y: 0, width: 200, height: footerView.height), text: "暂时没有评论", textColor: grayColor, font: font12)
                numLabel.textAlignment = .left
                footerView.addSubview(numLabel)
                return footerView
            }
        }
        return nil
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 1 {
            return 60
        }else if section == 2 {
            if self.favorsArray?.isEmpty == true {//没有
                return 60
            }
            
        }else if section == 3 {
            if self.commentsArray?.isEmpty == true {//没有
                return 60
            }
        }
        
        return 0.01
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 40
        }
        if section == 2 || section == 3 {
            return 60
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 || section == 2 || section == 3{
            
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: 0))
            headerView.backgroundColor = .white
            
            let numLabel = UILabel.createLabel(frame: .zero, text: "", textColor: .black, font: font16)
            numLabel.textAlignment = .left
            numLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            headerView.addSubview(numLabel)
            numLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(15)
                make.top.bottom.right.equalToSuperview()
            }
            var text : String = ""
            if section == 1 {
                text = self.contentModel?.postTitle ?? ""
            }else if section == 2 {
                text = "\(self.contentModel?.favorNum ?? 0)" + " 喜欢"
            }else {
                text = "\(self.contentModel?.commentNum ?? 0)" + " 评论"
            }
            numLabel.text = text
            return headerView
        }
        return nil
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WGTaDetailAuthorViewCell")
         cell?.selectionStyle = .none
        if indexPath.section == 0 {//作者视图
            
            (cell as! WGTaDetailAuthorViewCell).loadUIWithData(self.contentModel!)
            
        }else if indexPath.section == 1 {
            
            let contentLabelCell = tableView.dequeueReusableCell(withIdentifier: "WGTaDetailContentLabelCell")
            contentLabelCell?.selectionStyle = .none
            let contentImageCell = tableView.dequeueReusableCell(withIdentifier: "WGTaDetailContentImageViewCell")
            contentImageCell?.selectionStyle = .none
            if indexPath.row < self.contentModel?.contents?.count ?? 0 {
                
                let item : WGTaDetailContentDataItem = self.contentModel!.contents![indexPath.row]
                
                if item.type == 1 {//图片
                    (contentImageCell as! WGTaDetailContentImageViewCell).loadUIWithData(item)
                    return contentImageCell!
                }else {//文字
                    
                    (contentLabelCell as! WGTaDetailContentLabelCell).loadUIWithData(item)
                    return contentLabelCell!
                }
            }
            
        }else if indexPath.section == 2 {
            
            let favorsCell = tableView.dequeueReusableCell(withIdentifier: "WGTaDetailFavorsCell")
            favorsCell?.selectionStyle = .none
            
            (favorsCell as! WGTaDetailFavorsCell).favorArray = self.favorsArray
            
            return favorsCell!
            
        }else if indexPath.section == 3 {
            
            let commontCell = tableView.dequeueReusableCell(withIdentifier: "WGTaDetailCommontCell")
            commontCell?.selectionStyle = .none
            
            if self.commentsArray?.count ?? 0 > 0 {
                
                if indexPath.row < self.commentsArray?.count ?? 0 {
                    
                    let item : WGTaDetailCommontDataModel = self.commentsArray![indexPath.row]
                    
                    (commontCell as! WGTaDetailCommontCell).authorAvatarImageV?.kf.setImage(with: URL.init(string: item.avaPath!))
                    (commontCell as! WGTaDetailCommontCell).authorNameLabel?.text = item.nick
                    (commontCell as! WGTaDetailCommontCell).authorTagLabel?.text = item.content
                    (commontCell as! WGTaDetailCommontCell).timeLabel?.text = item.time
                    
                }
            }else {
                (commontCell as! WGTaDetailCommontCell).authorAvatarImageV?.isHidden = true
                (commontCell as! WGTaDetailCommontCell).authorNameLabel?.text = "无评论"
            }
            
            return commontCell!
            
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 60
        }else if indexPath.section == 1 {
            
            if indexPath.row < self.contentModel?.contents?.count ?? 0 {
                
                let item : WGTaDetailContentDataItem = self.contentModel!.contents![indexPath.row]
                if item.type == 1 {//图片
                    return WGTaDetailContentImageViewCell.heightWithItem(item)
                }else {//文字
                    return WGTaDetailContentLabelCell.heightWithItem(item)
                }
            }
        }
        
        return 60
    }
    
    
    /// 喜欢
    func loadFavorsData() -> Void {
        let dict = NSMutableDictionary()
        dict.setValue(self.postId, forKey: "postId")
        NetworkRequest(.taDetailFavorsApi(Dict: dict as! [String : Any])){ (respose) -> (Void) in
            
            if let favorsModel = WGTaDetailFavorsModel.deserialize(from: respose){
                if favorsModel.code == SuccessCode {
                    self.favorsArray = favorsModel.data!
                }
            }
        }
    }
    
    /// 评论
    func loadCommentData() -> Void {
        
        let dict = NSMutableDictionary()
        dict.setValue(self.postId, forKey: "objectId")
        dict.setValue("6", forKey: "type")
        dict.setValue("1", forKey: "page")
        dict.setValue("20", forKey: "size")
        
        NetworkRequest(.taDetailConmentApi(Dict: dict as! [String : Any])){ (respose) -> (Void) in
            
            if let commentsModel = WGTaDetailCommontModel.deserialize(from: respose){
                if commentsModel.code == SuccessCode {
                    self.commentsArray = commentsModel.data!
                }
            }
        }
    }
    
    
    /// 内容
    func loadContentData() -> Void {
        
        let dict = NSMutableDictionary()
        dict.setValue(self.postId, forKey: "postId")
        NetworkRequest(.taDetailContentApi(Dict: dict as! [String : Any])){ (respose) -> (Void) in
            
            if let discoverModel = WGTaDetailContentModel.deserialize(from: respose){
                if discoverModel.code == SuccessCode {
                    self.contentModel = discoverModel.data
                }
            }
        }
        
    }
    
}
