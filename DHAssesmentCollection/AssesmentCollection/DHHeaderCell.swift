//
//  DHHeaderCell.swift
//  DHAssesmentCollection
//
//  Created by Darren Hsu on 2019/7/15.
//  Copyright © 2019 D.H. All rights reserved.
//

import UIKit

class DHHeaderCell: UICollectionViewCell {
    static var id: String = String(describing: type(of: self))
    
    private var layout: DhAssesmentLayout?
    private var header: DhAssesmentItem?
    
    private var headerLabel: UILabel!
    private var headerLabelHightConstraint: NSLayoutConstraint!
    private var headerCollection: DHHeaderCollectionView!
    
    private var isSetupLabelStyle = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupUI()
    }
    
    func reloadData(_ layout: DhAssesmentLayout, header: DhAssesmentItem) {
        self.header = header
        self.layout = layout
        
        if !isSetupLabelStyle {
            self.headerLabel.font = layout.headerFount
            self.headerLabel.textAlignment = layout.headerTextAlignment
            self.headerLabel.backgroundColor = layout.headerBackgroundColor
            self.headerLabel.layer.borderColor = layout.headerBorderColor.cgColor
            self.headerLabel.layer.borderWidth = layout.headerBorderWidth
            self.isSetupLabelStyle = true
        }
        
        self.headerLabel.text = header.value
        
        if header.items == nil {
            self.headerLabelHightConstraint.constant = self.bounds.size.height
        }else {
            self.headerLabelHightConstraint.constant = self.bounds.size.height / 2
            self.headerCollection.reloadData(self.layout!, items: header.items!)
        }
        
        if header.value == nil {
            self.headerLabelHightConstraint.constant = 0
        }
    }
    
    func setupUI() {
        self.headerLabel = UILabel(frame: CGRect.zero)
        self.headerLabel.numberOfLines = 0
        self.addSubview(headerLabel)
        
        self.headerCollection = DHHeaderCollectionView(frame: CGRect.zero, collectionViewLayout: DHCollectionViewFlowLayout.createHorizontalFlowLayout())
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
