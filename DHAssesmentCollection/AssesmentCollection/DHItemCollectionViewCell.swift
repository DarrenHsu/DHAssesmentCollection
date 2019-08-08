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
    
    private var stackView: UIStackView!
    private var valueLabel: DHLabel!
    private var valueLabelConstraints: [NSLayoutConstraint] = []
    private var valueLabelWidthConstraint: NSLayoutConstraint!
    private var valueLabelHightConstraint: NSLayoutConstraint!
    
    private var equalConstraint: NSLayoutConstraint!
    
    private var valueCollectionViewConstraints: [NSLayoutConstraint] = []
    private var valueCollectionView: DHItemCollectionView!
    
    private var isSetupLabelStyle = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupStack()
        self.setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupStack()
        self.setupLabel()
    }
    
    func reloadData(_ layout: DhAssesmentLayout, item: DHAssesmentItem, isDisplayCell: Bool = false) {
        self.item = item
        self.layout = layout
        
        if self.equalConstraint != nil {
            self.removeConstraint(self.equalConstraint)
        }
        
        if self.valueCollectionView != nil {
            self.valueCollectionView.removeFromSuperview()
        }
        
        if !isSetupLabelStyle {
            self.valueLabel.font = layout.headerFount
            self.valueLabel.layer.borderColor = layout.headerBorderColor.cgColor
            self.valueLabel.layer.borderWidth = layout.headerBorderWidth
            self.isSetupLabelStyle = true
        }
        
        self.valueLabel.isHidden = item.value == nil ? true : false
        if !self.valueLabel.isHidden {
            self.valueLabel.backgroundColor = isDisplayCell ? layout.displayCellBackgroundColor : layout.headerBackgroundColor
            self.valueLabel.text = item.value
            self.valueLabel.textAlignment = isDisplayCell ? (item.textAlignment ?? .center) : layout.headerTextAlignment
        }
        
        if self.item?.items != nil {
            self.setupCollection()
            self.valueCollectionView.isDisplayColleciton = isDisplayCell
            self.valueCollectionView.reloadData(self.layout!, items: item.items!)
        }
        
        self.valueLabelWidthConstraint.constant = self.bounds.size.width
        
        if !self.valueLabel.isHidden && self.item?.items != nil {
            self.equalConstraint = NSLayoutConstraint(item: valueLabel!, attribute: .height, relatedBy: .equal, toItem: valueCollectionView!, attribute: .height, multiplier: 1, constant: 0)
            self.addConstraint(self.equalConstraint)
        }
        
        self.layoutIfNeeded()
    }
    
    func setupCollection() {
        self.valueCollectionView = DHItemCollectionView(frame: CGRect.zero, collectionViewLayout: DHCollectionViewFlowLayout.createHorizontalFlowLayout())
        self.valueCollectionView.addConstraints([
            NSLayoutConstraint(item: valueCollectionView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.bounds.size.width)
            ])
        
        self.stackView.addArrangedSubview(self.valueCollectionView)
    }
    
    func setupLabel() {
        self.valueLabel = DHLabel(frame: CGRect.zero)
        self.valueLabel.numberOfLines = 0
        self.valueLabelWidthConstraint = NSLayoutConstraint(item: valueLabel!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        self.valueLabelHightConstraint = NSLayoutConstraint(item: valueLabel!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        self.valueLabel.addConstraints([
            self.valueLabelWidthConstraint
            ])
        
        self.stackView.addArrangedSubview(self.valueLabel)
    }
    
    func setupStack() {
        self.stackView = UIStackView(frame: CGRect.zero)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false;
        self.stackView.alignment = .center
        self.stackView.axis = .vertical
        self.addSubview(stackView)
        
        self.addConstraints([
            NSLayoutConstraint(item: stackView!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            ])
    }
}

class DHLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        super.drawText(in: rect.inset(by: insets))
    }
}
