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
    var sapartorView: UIView!
    var sapartorHeightConstraint: NSLayoutConstraint!
    
    var fixSapartorView: UIView!
    var fixSapartorHeightConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    private func setupUI() {
        self.sapartorView = UIView(frame: .zero)
        self.sapartorView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.sapartorView)
        
        self.fixSapartorView = UIView(frame: .zero)
        self.fixSapartorView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.fixSapartorView)
        
        self.collectionView = DHItemCollectionView(frame: CGRect.zero, collectionViewLayout: DHCollectionViewFlowLayout.createHorizontalFlowLayout())
        self.backgroundColor = UIColor.clear
        self.collectionView.bounces = false
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)
        
        self.fixSapartorHeightConstraint = NSLayoutConstraint(item: fixSapartorView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        self.sapartorHeightConstraint = NSLayoutConstraint(item: sapartorView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        
        self.addConstraints([
            NSLayoutConstraint(item: fixSapartorView!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: fixSapartorView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: fixSapartorView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            self.fixSapartorHeightConstraint,
            
            NSLayoutConstraint(item: collectionView!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView!, attribute: .trailing, relatedBy: .equal, toItem: fixSapartorView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView!, attribute: .bottom, relatedBy: .equal, toItem: sapartorView!, attribute: .top, multiplier: 1, constant: 0),
            
            NSLayoutConstraint(item: sapartorView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: sapartorView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: sapartorView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            self.sapartorHeightConstraint,
            ])
    }
}
