//
//  DHHeaderCell.swift
//  DHAssesmentCollection
//
//  Created by Darren Hsu on 2019/7/15.
//  Copyright © 2019 D.H. All rights reserved.
//

import UIKit

class DHItemCollectionViewCell: UICollectionViewCell {
    static var id: String = String(describing: type(of: self))
    
    private var layout: DhAssesmentLayout?
    private var item: DHAssesmentItem?
    
    private var labels: [DHLabel] = []
    
    private var isSetupLabelStyle = false
    
    private var collectionType: DHItemCollectionViewType = .header
    private var collectionCellType: DHItemCollectionViewCellType = .itemGroup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupUI()
    }
        
    func reloadData(_ layout: DhAssesmentLayout, item: DHAssesmentItem, collectionType: DHItemCollectionViewType = .header, collectionCellType: DHItemCollectionViewCellType = .itemGroup ) {
        self.item = item
        self.layout = layout
        self.collectionType = collectionType
        self.collectionCellType = collectionCellType
        
        self.labels.forEach { $0.alpha = 0 }
        
        if let items = self.item?.allSubItem {
            var width: CGFloat = 0
            for i in 0..<items.count {
                if i != 0 && self.labels.count <= items.count {
                    let label = DHLabel(frame: CGRect.zero)
                    self.addSubview(label)
                    self.labels.append(label)
                }
                let subItem = items[i]
                if i > 0 { width += labels[i - 1].frame.size.width }
                let label = self.labels[i]
                label.frame = CGRect(x: width, y: 0, width: subItem.width!, height: self.layout!.displayCellHeight)
                label.text = subItem.value
                label.textAlignment = subItem.textAlignment!
                label.alpha = 1
                label.setupLayout(self.layout!, type: self.collectionType)
            }
        }else {
            let label = self.labels.first!
            label.frame = CGRect(x: 0, y: 0, width: self.item!.width!, height: self.layout!.displayCellHeight)
            label.text = self.item!.value
            label.textAlignment = self.item!.textAlignment!
            label.alpha = 1
            label.setupLayout(self.layout!, type: self.collectionType)
        }
        
        self.setNeedsLayout()
    }
    
    func setupUI() {
        self.labels.append(DHLabel(frame: CGRect.zero))
        self.addSubview(labels.first!)
    }
}
