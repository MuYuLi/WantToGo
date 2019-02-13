//
//  WGGuangCategoryListCell.swift
//  WantToGo
//
//  Created by Muyuli on 2019/2/11.
//  Copyright © 2019年 Muyuli. All rights reserved.
//

import UIKit

class WGGuangCategoryListCell: UICollectionViewCell {
    var imageV : UIImageView?
    var shadowImageV : UIImageView?
    var lovesImageV : UIImageView?
    
    var desLabel: UILabel?
    var titleLabel: UILabel?
    var lovesLabel: UILabel?
    var priceLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.width))
        self.contentView.addSubview(self.imageV!)
        
        self.shadowImageV = UIImageView.init()
        self.contentView.addSubview(self.shadowImageV!)
        self.shadowImageV?.image = UIImage.init(named: "theme_shadow")
       
        self.lovesImageV = UIImageView.init()
        self.contentView.addSubview(self.lovesImageV!)
        self.lovesImageV?.image = UIImage.init(named: "btn_favor_add")
        
        self.desLabel = UILabel.createLabel(frame: .zero, text: "", textColor: .black, font: font12)
        self.contentView.addSubview(self.desLabel!)
        self.titleLabel = UILabel.createLabel(frame: .zero, text: "", textColor: .black, font: font12)
        self.contentView.addSubview(self.titleLabel!)
        self.lovesLabel = UILabel.createLabel(frame: .zero, text: "", textColor: .black, font: font12)
        self.contentView.addSubview(self.lovesLabel!)
        self.priceLabel = UILabel.createLabel(frame: .zero, text: "", textColor: .white, font: font12)
        self.contentView.addSubview(self.priceLabel!)
      
    
        self.shadowImageV?.snp.makeConstraints({ (make) in
            make.right.left.bottom.equalTo(self.imageV!)
            make.height.equalTo(15)
        })
        
        self.priceLabel?.snp.makeConstraints({ (make) in
            make.left.bottom.top.equalTo(self.shadowImageV!)
        })
        
        self.desLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.imageV!.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        })
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.desLabel!.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        })

        self.lovesLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.titleLabel!.snp.bottom).offset(5)
            make.centerX.equalToSuperview().offset(15)
        })
        
        self.lovesImageV?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize.init(width: 14, height: 14))
            make.centerY.equalTo(self.lovesLabel!)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loadUIWithData(_ item : WGGuangCategoryDataListItem) -> Void {
        
        self.imageV?.kf.setImage(with: URL.init(string: item.image!))
        self.priceLabel?.text = "￥"+"\(item.price!)"
       
        self.desLabel?.text = item.brand
        self.titleLabel?.text = item.productDescription
        self.lovesLabel?.text = item.favNum
        
    }
    
}
