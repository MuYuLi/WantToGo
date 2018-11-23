//
//  MYLCardPageView.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/22.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit
import Kingfisher

class MYLCardPageView: UIView,UICollectionViewDelegate,UICollectionViewDataSource {

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

    public var collectionViewRect = CGRect(x: 0, y: 0, width: 0, height: 0){
        didSet{
            self.collectionView.frame = collectionViewRect
        }
    }
    public var pageControlRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    var collectionView : UICollectionView!
    let pageControl = UIPageControl()
    
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
        
        self.collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(MYLCardCollectionCell.self, forCellWithReuseIdentifier:"defaultCell")
        self.collectionView.contentSize = CGSize.init(width: self.frame.size.width, height: self.frame.size.height)
        self.collectionView.clipsToBounds = true
        self.addSubview(self.collectionView)
        
        self.addSubview(self.pageControl)
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
        
        if imageUrl.isEmpty && NSString.ValidaString.URL(imageUrl).isRight {
            cell.imageV?.kf.setImage(with: URL(string: imageUrl))
        }else{
            cell.imageV?.image = UIImage.init(imageLiteralResourceName: self.imageNameArray.object(at: indexPath.row) as! String)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }

}
