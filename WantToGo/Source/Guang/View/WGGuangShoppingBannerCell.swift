//
//  WGGuangShoppingBannerCell.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/28.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

class WGGuangShoppingBannerCell: UITableViewCell {

    let bannerViewHeight = 230
    let itemViewHeight = 200
    let itemViewWidth = 120
    var shoppingBannerView : WGGuangShoppingBannerView?
    
    var itemsSupView : UIScrollView?
    
    var itemDataArray : NSArray? {
        
        didSet {
            if itemDataArray!.count > 0 {
                
                self.removeItemViews()
                for item in itemDataArray as! [WGGuangShopingItem] {
                    
                    let i : Int = itemDataArray!.index(of: item)
                    let itemView = WGGuangShoppingItemView.init(frame: CGRect.init(x:itemViewWidth*i, y: 0, width: itemViewWidth, height: itemViewHeight))
                    self.itemsSupView?.addSubview(itemView)
                    
                    itemView.imageV?.kf.setImage(with: URL(string: item.image!))
                    itemView.titleLabel?.text = item.brandName
                    itemView.nameLabel?.text = item.keyword
                    itemView.priceLabel?.text = "￥" + "\(item.price!)"
                    
                    itemView.tipImageV?.isHidden = !((item.originalPrice! - item.price!) > 0)
                    
                }
                
                self.itemsSupView?.contentSize = CGSize.init(width: itemDataArray!.count*itemViewWidth, height: 0)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.shoppingBannerView = WGGuangShoppingBannerView.init(frame: CGRect.zero)
        self.contentView.addSubview(self.shoppingBannerView!)
        
        self.itemsSupView = UIScrollView.init(frame: CGRect.zero)
        self.contentView.addSubview(self.itemsSupView!)
        
        self.shoppingBannerView?.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(self.contentView)
            make.height.equalTo(bannerViewHeight)
        })
        
        self.itemsSupView?.snp.makeConstraints({ (make) in
            make.left.bottom.right.equalTo(self.contentView)
            make.top.equalTo(self.shoppingBannerView!.snp.bottom)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func removeItemViews() -> Void {
        for view : UIView in self.itemsSupView!.subviews {
            if (view is WGGuangShoppingItemView) {
                view.removeFromSuperview()
            }
        }
    }
    
    public func loadData(model : WGGuangShopingContentModel) -> Void {
        
        self.shoppingBannerView?.contentImageV?.kf.setImage(with: URL(string: model.image!))
    
        self.shoppingBannerView?.titleLabel?.text = model.title
        self.shoppingBannerView?.nameLabel?.text = model.name
        
        self.itemDataArray = model.items! as NSArray
    }
}


class WGGuangShoppingBannerView: UIControl {
    
    var contentImageV : UIImageView?
    var titleLabel : UILabel?
    var cutLine : UIView?
    var nameLabel : UILabel?
    var allButton : UIButton?
    var arrowsImageV : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let maskView = UIView()
        maskView.backgroundColor = UIColor.black
        maskView.alpha = 0.5
        self.contentImageV = UIImageView.init(frame: CGRect.zero)
        self.titleLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.white, font: UIFont.systemFont(ofSize: 16))
        self.cutLine = UIView.init(frame: CGRect.zero)
        self.cutLine?.backgroundColor = UIColor.white
        self.nameLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.white, font: UIFont.systemFont(ofSize: 10))
    
        self.allButton = UIButton.init(type: .custom)
        self.allButton?.setTitle("查看全部", for: .normal)
        self.allButton?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.allButton?.setTitleColor(UIColor.white, for: .normal)
        self.allButton?.layer.cornerRadius = 2
        self.allButton?.layer.borderWidth = 1
        self.allButton?.layer.borderColor = UIColor.white.cgColor
        
        self.arrowsImageV = UIImageView.init(frame: CGRect.zero)
        self.arrowsImageV?.image = UIImage.init(named: "guangContentArrow")
        
        self.addSubview(self.contentImageV!)
        self.addSubview(maskView)
        self.addSubview(self.titleLabel!)
        self.addSubview(self.cutLine!)
        self.addSubview(self.nameLabel!)
        self.addSubview(self.allButton!)
        self.addSubview(self.arrowsImageV!)
        
        self.contentImageV?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
        
        maskView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentImageV!)
        }
        
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.contentImageV!)
            make.top.equalTo(self.contentImageV!.snp.top).offset(80)
        })
        
        self.cutLine?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.contentImageV!)
            make.top.equalTo(self.titleLabel!.snp.bottom).offset(10)
            make.size.equalTo(CGSize.init(width: 40, height: 1))
        })
        
        self.nameLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.contentImageV!)
            make.top.equalTo(self.cutLine!.snp.bottom).offset(10)
        })
        self.allButton?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.contentImageV!)
            make.top.equalTo(self.nameLabel!.snp.bottom).offset(20)
            make.size.equalTo(CGSize.init(width: 80, height: 20))
        })
        self.arrowsImageV?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.contentImageV!)
            make.bottom.equalTo(self.contentImageV!.snp.bottom).offset(1)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class WGGuangShoppingItemView: UIControl {
    
    var imageV : UIImageView?
    var tipImageV : UIImageView?
    
    var titleLabel : UILabel?
    var nameLabel : UILabel?
    var priceLabel : UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageV = UIImageView.init(frame: CGRect.zero)
        self.tipImageV = UIImageView.init(frame: CGRect.zero)
        self.titleLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.black, font: UIFont.systemFont(ofSize: 12))
        self.nameLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.black, font: UIFont.systemFont(ofSize: 12))
        self.priceLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.black, font: UIFont.systemFont(ofSize: 12))
        
        self.addSubview(self.imageV!)
        self.addSubview(self.tipImageV!)
        self.addSubview(self.titleLabel!)
        self.addSubview(self.nameLabel!)
        self.addSubview(self.priceLabel!)
        
        self.tipImageV?.image = UIImage.init(named: "")

        self.imageV?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(self.imageV!.snp.width)
        })
       
        self.tipImageV?.snp.makeConstraints({ (make) in
            make.top.left.equalTo(self.imageV!)
            make.width.height.equalTo(20)
        })
        
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.imageV!)
            make.top.equalTo(self.imageV!.snp.bottom).offset(10)
        })
        
        self.nameLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.imageV!)
            make.top.equalTo(self.titleLabel!.snp.bottom).offset(5)
        })
        self.priceLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.imageV!)
            make.top.equalTo(self.nameLabel!.snp.bottom).offset(8)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
