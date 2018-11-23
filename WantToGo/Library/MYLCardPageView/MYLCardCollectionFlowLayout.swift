//
//  MYLCardCollectionFlowLayout.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/22.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit


class MYLCardCollectionCell : UICollectionViewCell {
    
    var imageV : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageV = UIImageView.init(frame: self.bounds)
        self.imageV?.layer.cornerRadius = 10
        self.imageV?.layer.masksToBounds = true
        self.imageV?.backgroundColor = UIColor.red
        self.contentView.addSubview(self.imageV!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class MYLCardCollectionFlowLayout: UICollectionViewFlowLayout {

    let SCREEN_WIDTH : CGFloat = UIScreen.main.bounds.size.width
    let SCREEN_HEIGHT : CGFloat = UIScreen.main.bounds.size.height
    let ITEM_ZOOM : CGFloat = 0.05
    let THE_ACTIVE_DISTANCE : CGFloat = 230
    let LEFT_OFFSET : CGFloat = 60

    override init() {
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        self.sectionInset = UIEdgeInsets.init(top: 0, left: LEFT_OFFSET, bottom: 0, right: LEFT_OFFSET)
        self.itemSize = CGSize.init(width: SCREEN_WIDTH - LEFT_OFFSET*2, height: (SCREEN_WIDTH - LEFT_OFFSET*2)/0.618)
        self.scrollDirection = UICollectionView.ScrollDirection(rawValue: 1)!
        self.minimumLineSpacing = 15.0
        self.minimumInteritemSpacing = 10
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let original = super.layoutAttributesForElements(in: rect)
        let attsArray = NSArray.init(array: original!) as! [UICollectionViewLayoutAttributes]
        var visiableRect = CGRect()
        visiableRect.origin = self.collectionView!.contentOffset
        visiableRect.size = self.collectionView!.bounds.size
        //cell中的item一个个取出来进行更改
        for atts in attsArray {
            
            var distance = visiableRect.midX - atts.center.x;
            distance = abs(distance);
            if (distance < SCREEN_WIDTH / 2 + self.itemSize.width){
           
                let zoom = 1 + ITEM_ZOOM * (1 - distance/THE_ACTIVE_DISTANCE);
                
                atts.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                atts.transform3D = CATransform3DTranslate(atts.transform3D, 0, -zoom * 25, 0);
                atts.alpha = zoom - ITEM_ZOOM;
            
            }
        }
        return attsArray
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var offsetAdjustment = MAXFLOAT
        let horizontalCenter_X = proposedContentOffset.x + self.collectionView!.bounds.width / 2
        let targetRect = CGRect.init(x: proposedContentOffset.x, y: 0, width: self.collectionView!.bounds.size.width, height: self.collectionView!.bounds.size.height)
        let original = super.layoutAttributesForElements(in: targetRect)
        let array = NSArray.init(array: original!) as! [UICollectionViewLayoutAttributes]
        for attributes in array {
            let itemHorizontalCenter_X = attributes.center.x
            
            if (abs(Float(itemHorizontalCenter_X - horizontalCenter_X)) < abs(offsetAdjustment))
            {
                offsetAdjustment = Float(itemHorizontalCenter_X - horizontalCenter_X);
            }
        }
  
        return CGPoint.init(x: proposedContentOffset.x + CGFloat(offsetAdjustment), y: proposedContentOffset.y)
    }
}
