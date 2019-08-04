//
//  DHHeaderCollectionView.swift
//  DHAssesmentCollection
//
//  Created by Darren Hsu on 2019/7/15.
//  Copyright © 2019 D.H. All rights reserved.
//

import UIKit

class DHHeaderCollectionView: DHCollectionView {
    
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
        
        self.register(DHHeaderCell.self, forCellWithReuseIdentifier: DHHeaderCell.id)
    }
    
    public func reloadData(_ layout: DhAssesmentLayout, items: [DhAssesmentItem]?) {
        self.layout = layout
        self.items = items
        
        self.reloadData()
    }
}

extension DHHeaderCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DHHeaderCell.id, for: indexPath) as! DHHeaderCell
        
        cell.reloadData(self.layout!, header: self.items![indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.viewDidMove?(sourceIndexPath.row, destinationIndexPath.row)
    }
}

extension DHHeaderCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.items![indexPath.row].width!, height: collectionView.bounds.size.height)
    }
}

extension DHHeaderCollectionView: UIScrollViewAccessibilityDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.viewDidScrollHorizontal?(scrollView.contentOffset.x)
    }
}
