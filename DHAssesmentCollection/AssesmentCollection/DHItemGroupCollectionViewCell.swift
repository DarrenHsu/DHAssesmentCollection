//
//  DHItemGroupCollectionViewCell.swift
//  DHAssesmentCollection
//
//  Created by wen on 2019/8/8.
//  Copyright © 2019 D.H. All rights reserved.
//

import UIKit

class DHItemGroupCollectionViewCell: UICollectionViewCell {
    static var id: String = String(describing: type(of: self))
    
    private var layout: DhAssesmentLayout?
    private var item: DHAssesmentItem?
    
    private var headerLabel: DHLabel!
    private var headerLabelHightConstraint: NSLayoutConstraint!
    private var headerCollection: DHItemGroupCollectionView!
    
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
        
        if !isSetupLabelStyle {
            self.headerLabel.font = self.layout!.headerFount
            self.headerLabel.backgroundColor = self.collectionType == .display ? self.layout!.displayCellBackgroundColor : self.layout!.headerBackgroundColor
            self.headerLabel.layer.borderColor = self.layout!.headerBorderColor.cgColor
            self.headerLabel.layer.borderWidth = self.layout!.headerBorderWidth
            self.isSetupLabelStyle = true
        }

        self.headerLabel.text = self.item!.value
        self.headerLabel.textAlignment = self.collectionCellType == .itemGroup ? (self.item!.textAlignment ?? .center) : self.layout!.headerTextAlignment

        if self.item!.items == nil {
            self.headerLabelHightConstraint.constant = self.bounds.size.height
        }else {
            self.headerLabelHightConstraint.constant = self.bounds.size.height / 2
            self.headerCollection.reloadData(self.layout!, items: self.item!.items!, collectionType: self.collectionType, collectionCellType: self.collectionCellType)
        }

        if self.item!.value == nil {
            self.headerLabelHightConstraint.constant = 0
        }
    }
    
    func setupUI() {
        self.headerLabel = DHLabel(frame: CGRect.zero)
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.headerLabel.numberOfLines = 0
        self.addSubview(headerLabel)
        
        self.headerCollection = DHItemGroupCollectionView(frame: CGRect.zero, collectionViewLayout: DHCollectionViewFlowLayout.createHorizontalFlowLayout())
        self.headerCollection.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(headerCollection)
        
        self.headerLabelHightConstraint = NSLayoutConstraint(item: headerLabel!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([
            self.headerLabelHightConstraint,
            
            NSLayoutConstraint(item: headerLabel!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headerLabel!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headerLabel!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            
            NSLayoutConstraint(item: headerCollection!, attribute: .top, relatedBy: .equal, toItem: headerLabel!, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headerCollection!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headerCollection!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headerCollection!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            ])
    }
}
