//
//  DHDisplayCollectionView.swift
//  DHAssesmentCollection
//
//  Created by Darren Hsu on 2019/7/15.
//  Copyright © 2019 D.H. All rights reserved.
//

import UIKit

class DHDisplayCollectionView: DHCollectionView {
    
    var displays: [DhAssesmentHeader] = []
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.dataSource = self
        self.delegate = self
        
        self.register(DHDisplayCell.self, forCellWithReuseIdentifier: DHDisplayCell.id)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.dataSource = self
        self.delegate = self
        
        self.register(DHDisplayCell.self, forCellWithReuseIdentifier: DHDisplayCell.id)
    }
    
    public func reloadData(_ layout: DhAssesmentLayout, headers: [DhAssesmentHeader]) {
        self.layout = layout
        self.headers = headers

        self.reloadData()
    }
    
    public func reloadData(_ layout: DhAssesmentLayout, display: [DhAssesmentDisplay]) {
        self.layout = layout
        self.displays = displays
        
        self.reloadData()
    }
}

extension DHDisplayCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.displays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DHDisplayCell.id, for: indexPath) as! DHDisplayCell
        
        cell.reloadData(self.layout!, header: self.headers[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {}
}

extension DHDisplayCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: headers[indexPath.row].textWidth, height: CGFloat(headers[indexPath.row].displayCount) * (layout?.displayCellHeight ?? 0))
    }
}

extension DHDisplayCollectionView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.viewDidScroll?(self, contentOffset)
    }
}
