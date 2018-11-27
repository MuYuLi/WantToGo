//
//  MYLCardPageView.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/22.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit
import Kingfisher

typealias SelectItemBlock = (_ index: NSInteger) -> Void

class MYLCardPageView: UIView,UICollectionViewDelegate,UICollectionViewDataSource {

    var selectItemBlock : SelectItemBlock?
    
    let cellWidth : CGFloat = 300
    let itemSpacing : CGFloat = 10
    let ButtonHeight : CGFloat = 80
    let lastRow : NSInteger = 0
    
    public var itemNumber : Int = 0
    var imageNameArray = NSMutableArray(){
        didSet{
            self.itemNumber = self.imageNameArray.count
            self.collectionView.reloadData()
        }
    }
    
    var collectionView : UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubViews() -> Void {
    
        //自定义UICollectionViewFlowLayout
        let layout = MYLCardCollectionFlowLayout.init()
        
        self.collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height), collectionViewLayout: layout)
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(MYLCardCollectionCell.self, forCellWithReuseIdentifier:"defaultCell")
        self.collectionView.contentSize = CGSize.init(width: self.frame.size.width, height: self.frame.size.height)
        self.collectionView.clipsToBounds = true
        self.collectionView.showsHorizontalScrollIndicator = false
        self.addSubview(self.collectionView)
    }
    
    //MARK: ---------    UICollectionDelegate && UICollectionDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemNumber
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath) as! MYLCardCollectionCell
        let imageUrl = self.imageNameArray.object(at: indexPath.row) as! String
        
        if !imageUrl.isEmpty {
            cell.imageV?.kf.setImage(with: URL(string: imageUrl))
        }else{
            cell.imageV?.image = UIImage.init(imageLiteralResourceName: self.imageNameArray.object(at: indexPath.row) as! String)
        }
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.selectItemBlock != nil {
            self.selectItemBlock!(indexPath.row)
        }
    }
}
