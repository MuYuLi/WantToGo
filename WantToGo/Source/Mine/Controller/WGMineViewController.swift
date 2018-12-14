//
//  MineViewController.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/27.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

class HeaderView : UICollectionReusableView{
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    
        let imageV = UIImageView.init(frame: self.bounds)
        imageV.image = UIImage.init(named: "img_bg")
        self.addSubview(imageV)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


class WGMineViewController: WGViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
   

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: kMainScreenWidth, height: 50)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "www", for: indexPath)
 
        
  
        return cell
        
    }
    

    var collectionView : UICollectionView?
    
//    var headerView : UICollectionReusableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.headerView = UICollectionReusableView.init(frame: CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: 200))
//        let imageV = UIImageView.init(frame: self.headerView!.bounds)
//        imageV.image = UIImage.init(named: "img_bg")
        self.initCollectionView()
        
    }
    
    func initCollectionView() -> Void {
        
        let customFlowLayout = WGMineCollectionViewFlowLayout()
        
        customFlowLayout.headerReferenceSize = CGSize.init(width: kMainScreenWidth, height: 200)
        customFlowLayout.footerReferenceSize = CGSize.init(width: kMainScreenWidth, height: 20)
        customFlowLayout.minimumInteritemSpacing = 0
        customFlowLayout.minimumLineSpacing = 0
        customFlowLayout.itemSize = CGSize.init(width: kMainScreenWidth / 3.000006, height: kMainScreenWidth / 3.00006)
        customFlowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 10, right: 0)
        
        
        self.collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: CGFloat(STATUS_BAR_HEIGHT), width: kMainScreenWidth, height: IPHONE_CONTENT_HEIGHT), collectionViewLayout: customFlowLayout)
        
        self.view.addSubview(self.collectionView!)
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self

        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "www")
    
//        let header_y : CGFloat = 200;

//        self.collectionView?.contentInset = UIEdgeInsets.init(top: header_y, left: 0, bottom: 0, right: 0)

//        self.headerView?.frame = CGRect.init(x: 0, y: header_y, width: kMainScreenWidth, height: header_y)
      
//        self.collectionView?.addSubview(self.headerView!)
//        self.collectionView!.contentOffset = CGPoint.init(x: 0, y: header_y)
//
        
        
        
        
        
        self.collectionView?.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerV = UICollectionReusableView()
        if kind == UICollectionView.elementKindSectionHeader {
            
            let headerV = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! HeaderView
            
            return headerV
        }
        return headerV
    }
    
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        let yOffset : CGFloat = scrollView.contentOffset.y
//        // 下拉 纵向偏移量变小 变成负的
//        if yOffset < 0 {
//            // 拉伸后图片的高度
//            let totalOffset = 200 - yOffset;
//            // 图片放大比例
//            let scale = totalOffset / 200;
//            // 拉伸后图片位置
//            self.headerView!.frame = CGRect.init(x: -(kMainScreenWidth * scale - kMainScreenWidth) / 2, y: yOffset, width: kMainScreenWidth * scale, height: totalOffset)
//
//        }else{
//
//            self.headerView!.frame = CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: 200)
//        }
//
//    }
    
    

}
