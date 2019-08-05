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
    
    private var headerLabel: DHLabel!
    private var headerLabelHightConstraint: NSLayoutConstraint!
    private var headerCollection: DHItemCollectionView!
    
    private var isSetupLabelStyle = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupUI()
    }
    
    func reloadData(_ layout: DhAssesmentLayout, item: DHAssesmentItem, isDisplayCell: Bool = false) {
        self.item = item
        self.layout = layout
        
        if !isSetupLabelStyle {
            self.headerLabel.font = layout.headerFount
            self.headerLabel.backgroundColor = isDisplayCell ? layout.displayCellBackgroundColor : layout.headerBackgroundColor
            self.headerLabel.layer.borderColor = layout.headerBorderColor.cgColor
            self.headerLabel.layer.borderWidth = layout.headerBorderWidth
            self.isSetupLabelStyle = true
            self.headerCollection.isDisplayColleciton = isDisplayCell
        }
        
        self.headerLabel.text = item.value
        self.headerLabel.textAlignment = isDisplayCell ? (item.textAlignment ?? .center) : layout.headerTextAlignment
        
        if item.items == nil {
            self.headerLabelHightConstraint.constant = self.bounds.size.height
        }else {
            self.headerLabelHightConstraint.constant = self.bounds.size.height / 2
            self.headerCollection.reloadData(self.layout!, items: item.items!)
        }
        
        if item.value == nil {
            self.headerLabelHightConstraint.constant = 0
        }
    }
    
    func setupUI() {
        self.headerLabel = DHLabel(frame: CGRect.zero)
        self.headerLabel.numberOfLines = 0
        self.addSubview(headerLabel)
        
        self.headerCollection = DHItemCollectionView(frame: CGRect.zero, collectionViewLayout: DHCollectionViewFlowLayout.createHorizontalFlowLayout())
        self.addSubview(headerCollection)
        
        self.headerLabelHightConstraint = NSLayoutConstraint(item: headerLabel!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        self.headerLabel.addConstraint(self.headerLabelHightConstraint)
        
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint(item: headerLabel!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headerLabel!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headerLabel!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
            ])

        self.headerCollection.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint(item: headerCollection!, attribute: .top, relatedBy: .equal, toItem: headerLabel!, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headerCollection!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headerCollection!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headerCollection!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            ])
    }
    
    deinit {
        print("\(String(describing: type(of: self))) deinit")
    }
}

class DHLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        super.drawText(in: rect.inset(by: insets))
    }
}
