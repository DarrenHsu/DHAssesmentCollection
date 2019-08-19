//
//  DHItemCollectionView.swift
//  DHAssesmentCollection
//
//  Created by Darren Hsu on 2019/7/15.
//  Copyright © 2019 D.H. All rights reserved.
//

import UIKit

class DHItemCollectionView: DHCollectionView {
    
    private var collectionType: DHItemCollectionViewType = .header
    private var collectionCellType: DHItemCollectionViewCellType = .itemGroup
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupUI()
    }
    
    private func setupUI() {
        self.dataSource = self
        self.delegate = self
        
        self.bounces = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.register(DHItemCollectionViewCell.self, forCellWithReuseIdentifier: DHItemCollectionViewCell.id)
    }
    
    public func reloadData(_ layout: DhAssesmentLayout, items: [DHAssesmentItem]?, collectionType: DHItemCollectionViewType = .header, collectionCellType: DHItemCollectionViewCellType = .itemGroup ) {
        self.layout = layout
        self.items = items
        self.collectionType = collectionType
        self.collectionCellType = collectionCellType
        
        self.reloadData()
    }
}

extension DHItemCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DHItemCollectionViewCell.id, for: indexPath) as! DHItemCollectionViewCell
        cell.reloadData(self.layout!, item: self.items![indexPath.row], collectionType: self.collectionType, collectionCellType: .item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.viewDidMove?(sourceIndexPath.row, destinationIndexPath.row)
    }
}

extension DHItemCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.items![indexPath.row].width!, height: collectionView.bounds.size.height)
    }
}

extension DHItemCollectionView: UIScrollViewAccessibilityDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.viewDidScrollHorizontal?(scrollView.contentOffset.x)
    }
}
