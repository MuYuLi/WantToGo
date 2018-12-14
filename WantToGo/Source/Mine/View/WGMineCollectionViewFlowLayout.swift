//
//  WGMineCollectionViewFlowLayout.swift
//  WantToGo
//
//  Created by Muyuli on 2018/12/5.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import UIKit

class WGMineCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let collectionView = self.collectionView
        let insets = collectionView?.contentInset
        let offset = collectionView?.contentOffset
        let minY = -((insets?.top)!)
        
        let attributesArray = super.layoutAttributesForElements(in: rect)
        if offset!.y < minY {
            let headerSize = self.headerReferenceSize
            let deltaY = CGFloat(fabsf(Float((offset?.y)! - CGFloat(minY))))
            for attrs:UICollectionViewLayoutAttributes in attributesArray! {
                if attrs.representedElementKind == UICollectionView.elementKindSectionHeader {
                    var headerRect = attrs.frame
                    headerRect.size.height = max(minY, headerSize.height + deltaY)
                   
//                    headerRect.origin.y = headerRect.origin.y - deltaY
                    attrs.frame = headerRect
                    break
                    
                }
            }
        }
        return attributesArray
    }
}
