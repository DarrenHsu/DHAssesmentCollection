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

        self.stackView.arrangedSubviews.forEach { ($0 as! DHLabel).widthConstraint.constant = 0 }
        
        if let items = self.item?.allSubItem {
            for i in 0..<items.count {
                if i != 0 && self.stackView.arrangedSubviews.count <= items.count {
                    let label = DHLabel(frame: CGRect.zero)
                    self.stackView.addArrangedSubview(label)
                }
                
                let subItem = items[i]
                let label = self.stackView.arrangedSubviews[i] as! DHLabel
                label.widthConstraint.constant = subItem.width!
                label.text = subItem.value
                label.textAlignment = subItem.textAlignment!
                label.isHidden = false
                label.setupLayout(self.layout!, type: self.collectionType)
            }
        }else {
            let label = self.stackView.arrangedSubviews.first as! DHLabel
            label.text = self.item!.value
            label.textAlignment = self.item!.textAlignment!
            label.isHidden = false
            label.setupLayout(self.layout!, type: self.collectionType)
        }
    }
    
    func setupUI() {
        self.stackView = UIStackView(frame: CGRect.zero)
        self.stackView.axis = .horizontal
        self.addSubview(self.stackView)
        
        self.stackView.addArrangedSubview(DHLabel(frame: CGRect.zero))
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint(item: stackView!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            ])
    }
    
    deinit {
        print("\(String(describing: type(of: self))) deinit")
    }
}
