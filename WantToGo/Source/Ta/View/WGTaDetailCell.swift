//
//  WGTaDetailCell.swift
//  WantToGo
//
//  Created by Muyuli on 2019/2/12.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit

class WGTaDetailCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class WGTaDetailAuthorViewCell: UITableViewCell {
    
    var authorView : WGTaDiscoverAuthorView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.authorView = WGTaDiscoverAuthorView.init(frame: CGRect.zero)
        self.contentView.addSubview(self.authorView!)
       
        self.authorView?.snp.makeConstraints({ (make) in
            make.top.right.left.bottom.equalToSuperview()
        })
        
    }
    
    func loadUIWithData(_ item : WGTaDetailContentDataModel) -> Void {
        
        self.authorView?.authorAvatarImageV?.kf.setImage(with: URL.init(string: item.authorAvatarURL!))
        self.authorView?.authorNameLabel?.text = item.authorName!
        self.authorView?.authorTagLabel?.text = item.authorTag!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


class WGTaDetailContentLabelCell: UITableViewCell {

    var titleLabel : UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.titleLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: .black, font:font14,textAligent:.left)
        self.titleLabel?.numberOfLines = 0
        self.contentView.addSubview(self.titleLabel!)
        
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.top.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        })
        
    }
    
    func loadUIWithData(_ item : WGTaDetailContentDataItem) -> Void {
       
        let paraph = NSMutableParagraphStyle()
        //将行间距设置为28
        paraph.lineSpacing = 5
        //样式属性集合
        let attributes = [NSAttributedString.Key.font: font14,NSAttributedString.Key.paragraphStyle: paraph]
        self.titleLabel?.attributedText = NSAttributedString(string: item.content!, attributes: attributes)
        
    }
    
    
    class func heightWithItem(_ item : WGTaDetailContentDataItem) -> CGFloat {
        
        return CGFloat(30) + (item.content?.wg_heightForComment(font14, kMainScreenWidth-30,5) ?? 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class WGTaDetailContentImageViewCell: UITableViewCell {
    
    var contentImageV : UIImageView?
    var titleLabel : UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentImageV = UIImageView.init(frame: CGRect.zero)
        self.contentView.addSubview(self.contentImageV!)
        
//        self.titleLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: .black, font:font14,textAligent:.left)
//        self.titleLabel?.numberOfLines = 0
//        self.contentView.addSubview(self.titleLabel!)
        
//        self.titleLabel?.snp.makeConstraints({ (make) in
//            make.bottom.equalToSuperview().offset(15)
//            make.left.equalToSuperview().offset(15)
//            make.right.equalToSuperview().offset(-15)
//        })
        
        self.contentImageV?.snp.makeConstraints({ (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 5, left: 15, bottom: 5, right: 15))
        })
        
    }
    
    func loadUIWithData(_ item : WGTaDetailContentDataItem) -> Void {
        
//        self.titleLabel?.text = item.imgKey!
        self.contentImageV?.kf.setImage(with: URL.init(string: item.content!))
    }
    
    
    class func heightWithItem(_ item : WGTaDetailContentDataItem) -> CGFloat {
        
        let rate = Float(item.imgHeight!)/Float(item.imgWidth!)
        
        let imageH = CGFloat(kMainScreenWidth - 30)*CGFloat(rate)
        return imageH + 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


/// 评论
class WGTaDetailCommontCell: UITableViewCell {
    
    var authorAvatarImageV : UIImageView?//头像
    var authorNameLabel : UILabel?//昵称
    var authorTagLabel : UILabel?//描述
    var timeLabel : UILabel?//时间
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.authorAvatarImageV = UIImageView.init(frame: CGRect.zero)
        self.authorAvatarImageV?.clipsToBounds = true
        self.authorAvatarImageV?.layer.cornerRadius = 15
        self.authorAvatarImageV?.layer.borderWidth = 1
        self.authorAvatarImageV?.layer.borderColor = UIColor.gray.cgColor
        
        self.authorNameLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.black, font:UIFont.systemFont(ofSize: 14))
        
        self.authorTagLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.gray, font:UIFont.systemFont(ofSize: 12))
        
        self.timeLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.gray, font:UIFont.systemFont(ofSize: 12))
        
        self.contentView.addSubview(self.authorAvatarImageV!)
        self.contentView.addSubview(self.authorNameLabel!)
        self.contentView.addSubview(self.authorTagLabel!)
        self.contentView.addSubview(self.timeLabel!)

  
        self.authorAvatarImageV?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize.init(width: 30, height: 30))
        })
        
        self.authorNameLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.contentView.snp.centerY).offset(-5)
            make.left.equalTo(self.authorAvatarImageV!.snp.right).offset(15)
        })
        
        self.authorTagLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView.snp.centerY).offset(5)
            make.left.equalTo(self.authorNameLabel!)
        })
        
        self.timeLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        })
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


/// 喜欢
class WGTaDetailFavorsCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    var itemsSupView : UICollectionView?
    
    var dataSource : Array<WGTaDetailFavorsDataModel>? {
        didSet {
            self.itemsSupView?.reloadData()
        }
    }
    
    var favorArray : Array<WGTaDetailFavorsDataModel>? {
        didSet{
            
            if favorArray?.count ?? 0 > 6 {
                self.dataSource = Array(favorArray?[0...5] ?? [])
                
            }else{
                self.dataSource = favorArray
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initCollectionView()
    }
    
    
    func initCollectionView() -> Void{
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: kMainScreenWidth/7, height: kMainScreenWidth/7)
        layout.scrollDirection = .horizontal;
        //水平间隔
        layout.minimumInteritemSpacing = 0.0
        //垂直行间距
        layout.minimumLineSpacing = 0.0
        
        self.itemsSupView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        self.itemsSupView?.delegate = self
        self.itemsSupView?.dataSource = self
        self.itemsSupView?.backgroundColor = UIColor.white
        self.itemsSupView?.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(self.itemsSupView!)
        
        self.itemsSupView?.register(WGTaDetailFavorsItemView.self, forCellWithReuseIdentifier: "WGTaDetailFavorsItemView")

        self.itemsSupView?.snp.makeConstraints({ (make) in
            make.left.bottom.right.top.equalTo(self.contentView)
           
        })
    }
    
    //MARK: --------- UICollectionViewDataSource,UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1 + (self.dataSource?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : WGTaDetailFavorsItemView = collectionView.dequeueReusableCell(withReuseIdentifier: "WGTaDetailFavorsItemView", for: indexPath) as! WGTaDetailFavorsItemView
        
        if indexPath.row < self.dataSource?.count ?? 0 {
            
            let item = self.dataSource![indexPath.row]
            
            cell.imageV?.kf.setImage(with: URL(string: item.avaPath!))
            
        }else{
             cell.imageV?.image = UIImage.init(named: "more_faver_people")
        }
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class WGTaDetailFavorsItemView: UICollectionViewCell {
    var imageV : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageV = UIImageView.init(frame: CGRect.zero)
        self.contentView.addSubview(self.imageV!)
        self.imageV?.clipsToBounds = true
        self.imageV?.layer.cornerRadius = 15
        
//        self.imageV?.layer.borderWidth = 0
//        self.imageV?.layer.borderColor = UIColor.gray.cgColor
        
        self.imageV?.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 30, height: 30))
        })
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
