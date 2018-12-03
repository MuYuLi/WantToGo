//
//  WGGuangCatrgoryHeaderView.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/27.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

typealias SelectItemViewBlock = (_ index : NSInteger) -> Void

class WGGuangCatrgoryHeaderView: WGView {
    
    var selectItemBlock : SelectItemViewBlock?
    
    var dataArray : NSArray? {
        didSet{
            for view in self.subviews {
                view.removeFromSuperview()
            }
            
            if dataArray!.count > 0 {
        
                let itemWidth = kMainScreenWidth/4
                for itemModel in dataArray as! [WGGuangCatrgoryItem] {
                    let i : Int = dataArray!.index(of: itemModel)
                    let col:Int = i%4
                    let row:Int = i/4
                    let itemView = WGGuangCatrgoryItemView.init(frame: CGRect.init(x: CGFloat(itemWidth)*CGFloat(col), y: CGFloat(row) * CGFloat(itemWidth), width: itemWidth, height: itemWidth))
                    self.addSubview(itemView)
                    itemView.imageV?.kf.setImage(with: URL(string: itemModel.logo!))
                    itemView.titleLable?.text = itemModel.name
                    itemView.tag = i + 100
                    itemView.addTarget(self, action: #selector(self.action(_ :)), for: .touchUpInside)
                    
                }
                let bottomViwe = UIView.init(frame: CGRect.zero)
                bottomViwe.backgroundColor = KBackgroudColor
                self.addSubview(bottomViwe)
                bottomViwe.snp.makeConstraints { (make) in
                    make.bottom.left.right.equalToSuperview()
                    make.height.equalTo(10)
                }
            }
        }
    }
    
    
    @objc func action(_ button: UIControl) -> Void {
        if self.selectItemBlock != nil {
            self.selectItemBlock!(button.tag - 100)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        for i in 0...10 {
            
            let view = WGGuangCatrgoryItemView()
            self.addSubview(view)
            view.frame = CGRect.init(x: 10+10*i, y: 0, width: 20, height: 20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class WGGuangCatrgoryItemView : UIControl {
    
    var imageV : UIImageView?
    var titleLable : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.titleLable = UILabel.createLabel(frame: CGRect.zero, text: "", textColor: UIColor.black,font:UIFont.systemFont(ofSize: 12))
        self.addSubview(self.titleLable!)
        
        self.imageV = UIImageView.init(frame: CGRect.zero)
        self.addSubview(self.imageV!)
        
        self.imageV?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(20)
            make.size.equalTo(CGSize.init(width: 35, height: 35))
        })
        
        self.titleLable?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-15)
        })
    
    }
    
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
