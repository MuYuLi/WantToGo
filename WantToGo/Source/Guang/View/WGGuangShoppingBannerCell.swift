//
//  WGGuangShoppingBannerCell.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/28.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

enum SelectItemsType {
    case banner
    case item
}

typealias ScrollViewLoadMoreBlock = () -> Void
typealias SelectItemsBlock = (_ type : SelectItemsType, _ index : NSInteger) -> Void

class WGGuangShoppingBannerCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    let bannerViewHeight = 230
    let itemViewHeight = 200
    let itemViewWidth = 120
    var shoppingBannerView : WGGuangShoppingBannerView?
    
    var itemsSupView : UICollectionView?
    var scrollViewLoadMoreBlock : ScrollViewLoadMoreBlock?
    var selectItemsBlock : SelectItemsBlock?
    
    var itemDataArray : NSArray?
    {
        didSet {
            self.itemsSupView?.contentOffset = CGPoint.init(x: 0, y: 0)
            self.itemsSupView?.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.shoppingBannerView = WGGuangShoppingBannerView.init(frame: CGRect.zero)
        self.contentView.addSubview(self.shoppingBannerView!)
  
        self.shoppingBannerView?.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(self.contentView)
            make.height.equalTo(bannerViewHeight)
        })
        
        self.shoppingBannerView?.maskV?.addTarget(self, action: #selector(self.selectShoppingBannerView(_ :)), for: .touchUpInside)
        
        self.initCollectionView()
    }

    func initCollectionView() -> Void{
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: itemViewWidth, height: itemViewHeight)
        layout.scrollDirection = .horizontal;

        self.itemsSupView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        self.itemsSupView?.delegate = self
        self.itemsSupView?.dataSource = self
        self.itemsSupView?.backgroundColor = UIColor.white
        self.itemsSupView?.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(self.itemsSupView!)
        
        self.itemsSupView?.register(WGGuangShoppingItemView.self, forCellWithReuseIdentifier: "WGGuangShoppingItemView")
        self.itemsSupView?.register(WGGuangCollectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerView")
        
        self.itemsSupView?.snp.makeConstraints({ (make) in
            make.left.bottom.right.equalTo(self.contentView)
            make.top.equalTo(self.shoppingBannerView!.snp.bottom)
        })
    }
    
    
    //MARK: --------- Action
    
    @objc func selectShoppingBannerView(_ sender : UIControl) -> Void {
        if self.selectItemsBlock != nil {
            self.selectItemsBlock!(.banner,-1)
        }
    }
    
    
    public func loadData(model : WGGuangShopingContentModel) -> Void {
        
        self.shoppingBannerView?.contentImageV?.kf.setImage(with: URL(string: model.image!))
        self.shoppingBannerView?.titleLabel?.text = model.name
        self.shoppingBannerView?.nameLabel?.text = model.title
        
    }
    
    //MARK: --------- UIScrollViewDelegate
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let scrollX = scrollView.contentOffset.x
        
        if CGFloat(scrollX+kMainScreenWidth) > CGFloat(self.itemDataArray!.count*itemViewWidth+50) {
            
            if self.scrollViewLoadMoreBlock != nil {
                self.scrollViewLoadMoreBlock!()
            }
        }
    }
    
    //MARK: --------- UICollectionViewDataSource,UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemDataArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : WGGuangShoppingItemView = collectionView.dequeueReusableCell(withReuseIdentifier: "WGGuangShoppingItemView", for: indexPath) as! WGGuangShoppingItemView
        
        if indexPath.row < self.itemDataArray!.count {
            
            let item = self.itemDataArray?.object(at: indexPath.row) as! WGGuangShopingItem
            
            cell.imageV?.kf.setImage(with: URL(string: item.image!))
            cell.titleLabel?.text = item.brandName
            cell.nameLabel?.text = item.keyword
            cell.priceLabel?.text = "￥" + "\(item.price!)"
            cell.tipImageV?.isHidden = !((item.originalPrice! - item.price!) > 0)
            
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
    {
        return CGSize (width: 40, height: itemViewHeight)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var footerView = WGGuangCollectionFooterView();
    
        if kind == UICollectionView.elementKindSectionFooter {
            
            footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footerView", for: indexPath) as! WGGuangCollectionFooterView
        }
        return footerView
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if self.selectItemsBlock != nil {
            self.selectItemsBlock!(.item,indexPath.row)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}


class WGGuangShoppingBannerView: UIControl {
    
    var contentImageV : UIImageView?
    var titleLabel : UILabel?
    var cutLine : UIView?
    var nameLabel : UILabel?
    var allButton : UIButton?
    var arrowsImageV : UIImageView?
    var maskV : UIControl?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.maskV = UIControl()
        self.maskV?.backgroundColor = UIColor.black
        self.maskV?.alpha = 0.5
        
        self.contentImageV = UIImageView.init(frame: CGRect.zero)
        self.contentImageV?.isUserInteractionEnabled = true
        self.titleLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.white, font: UIFont.systemFont(ofSize: 18))
        self.cutLine = UIView.init(frame: CGRect.zero)
        self.cutLine?.backgroundColor = UIColor.white
        self.nameLabel = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.white, font: UIFont.systemFont(ofSize: 14))
    
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
        self.addSubview(self.maskV!)
        self.addSubview(self.titleLabel!)
        self.addSubview(self.cutLine!)
        self.addSubview(self.nameLabel!)
        self.addSubview(self.allButton!)
        self.addSubview(self.arrowsImageV!)
        
        self.contentImageV?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
        
        self.maskV?.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentImageV!)
        }
        
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.contentImageV!)
            make.top.equalTo(self.contentImageV!.snp.top).offset(60)
        })
        
        self.cutLine?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.contentImageV!)
            make.top.equalTo(self.titleLabel!.snp.bottom).offset(8)
            make.size.equalTo(CGSize.init(width: 25, height: 1))
        })
        
        self.nameLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.contentImageV!)
            make.top.equalTo(self.cutLine!.snp.bottom).offset(8)
        })
        self.allButton?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.contentImageV!)
            make.top.equalTo(self.nameLabel!.snp.bottom).offset(20)
            make.size.equalTo(CGSize.init(width: 65, height: 25))
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


class WGGuangShoppingItemView: UICollectionViewCell {
    
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
        
        self.contentView.addSubview(self.imageV!)
        self.contentView.addSubview(self.tipImageV!)
        self.contentView.addSubview(self.titleLabel!)
        self.contentView.addSubview(self.nameLabel!)
        self.contentView.addSubview(self.priceLabel!)
        
        self.tipImageV?.image = UIImage.init(named: "")

        self.imageV?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.left.equalTo(self.contentView).offset(15)
            make.right.equalTo(self.contentView).offset(-15)
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

class WGGuangCollectionFooterView: UICollectionReusableView {
    
    var moreLabel : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = KBackgroudColor
        self.moreLabel = UILabel.createLabel(frame: CGRect.zero, text: "查看更多", textColor:KMainColor)
        self.moreLabel?.transform = CGAffineTransform.init(rotationAngle: -.pi/2)
        self.addSubview(self.moreLabel!)
        
        self.moreLabel?.snp.makeConstraints({ (make) in
            make.center.equalTo(self)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
