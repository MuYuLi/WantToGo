//
//  MYLCardPageView.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/22.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit
import Kingfisher

typealias SelectItemBlock = (_ index: NSInteger, _ currentImageVFrame : CGRect) -> Void

class MYLCardPageView: UIView,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    var currentImageVFrame : CGRect?
    
    var selectItemBlock : SelectItemBlock?
    
    let cellWidth : CGFloat = 300
    let itemSpacing : CGFloat = 10
    let ButtonHeight : CGFloat = 80
    let lastRow : NSInteger = 0
    
    var selectedIndex : NSInteger = 0
    
    
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
        self.collectionView.clipsToBounds = false
        self.collectionView.isPagingEnabled = false
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
        if indexPath.row == 0 {
            self.currentImageVFrame = cell.imageV?.frame
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MYLCardCollectionCell
        
        self.currentImageVFrame = cell.imageV?.bounds
        
        if self.selectItemBlock != nil {
            self.selectItemBlock!(indexPath.row,self.currentImageVFrame!)
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        // Destination x
        let x = targetContentOffset.pointee.x
        // Page width equals to cell width
        let pageWidth = kMainScreenWidth - 45
        // Check which way to move
        let movedX = x - pageWidth * CGFloat(selectedIndex)
        if movedX < -pageWidth * 0.5 {
            // Move left
            selectedIndex -= 1
        } else if movedX > pageWidth * 0.5 {
            // Move right
            selectedIndex += 1
        }
        if abs(velocity.x) >= 2 {
            targetContentOffset.pointee.x = pageWidth * CGFloat(selectedIndex)
        } else {
            // If velocity is too slow, stop and move with default velocity
            targetContentOffset.pointee.x = scrollView.contentOffset.x
            scrollView.setContentOffset(CGPoint(x: pageWidth * CGFloat(selectedIndex), y: scrollView.contentOffset.y), animated: true)
        }
        
        
//        let targetOffset : CGPoint = self.nearestTargetOffsetForOffset(offset: targetContentOffset.pointee)
//
//        targetContentOffset.pointee.x = targetOffset.x
//        targetContentOffset.pointee.y = targetOffset.y
    }

    func nearestTargetOffsetForOffset(offset:CGPoint)->CGPoint{
        let pageSize : CGFloat = kMainScreenWidth - 45
        let page : Int = Int(roundf(Float(offset.x) / Float(pageSize)))
        let targetX : CGFloat = CGFloat(pageSize) * CGFloat(page)

        return CGPoint.init(x: targetX, y: offset.y)

    }

}

