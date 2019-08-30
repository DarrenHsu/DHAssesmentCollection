//
//  DHCollectionViewFlowLayout.swift
//  DHAssesmentCollection
//
//  Created by wen on 2019/8/2.
//  Copyright © 2019 D.H. All rights reserved.
//

import UIKit

enum DHItemCollectionViewType {
    case header
    case display
}

enum DHItemCollectionViewCellType {
    case itemGroup
    case item
}

class DHCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    public static var movingAlpha: CGFloat = 0.4
    
    public static func createHorizontalFlowLayout() -> UICollectionViewFlowLayout {
        let layout = DHCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.headerReferenceSize = CGSize.zero
        return layout
    }
    
    override func invalidationContext(forInteractivelyMovingItems targetIndexPaths: [IndexPath], withTargetPosition targetPosition: CGPoint, previousIndexPaths: [IndexPath], previousPosition: CGPoint) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forInteractivelyMovingItems: targetIndexPaths, withTargetPosition: targetPosition, previousIndexPaths: previousIndexPaths, previousPosition: previousPosition)
        if previousIndexPaths.first!.item != targetIndexPaths.first!.item {
            if let c = collectionView, c is DHCollectionView {
                (c as! DHCollectionView).changeItem(previousIndexPaths.first!.row, to: targetIndexPaths.last!.row)
            }
        }
        return context
    }
    
    override func layoutAttributesForInteractivelyMovingItem(at indexPath: IndexPath, withTargetPosition position: CGPoint) -> UICollectionViewLayoutAttributes {
        let attributes = super.layoutAttributesForInteractivelyMovingItem(at: indexPath, withTargetPosition: position)
        attributes.alpha = DHCollectionViewFlowLayout.movingAlpha
        return attributes
    }    
}
