//
//  DHTableViewCell.swift
//  DHAssesmentCollection
//
//  Created by Darren Hsu on 2019/8/4.
//  Copyright © 2019 D.H. All rights reserved.
//

import UIKit

class DHTableViewCell: UITableViewCell {
    static var id: String = String(describing: type(of: self))
    
    var collectionView: DHItemCollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    private func setupUI() {
        self.collectionView = DHItemCollectionView(frame: CGRect.zero, collectionViewLayout: DHCollectionViewFlowLayout.createHorizontalFlowLayout())
        self.backgroundColor = UIColor.clear
        self.collectionView.bounces = false
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.isDisplayColleciton = true
        self.addSubview(collectionView)
        
        self.addConstraints([
            NSLayoutConstraint(item: collectionView!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            ])
    }
}
