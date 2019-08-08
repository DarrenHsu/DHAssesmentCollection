//
//  DHTableView.swift
//  DHAssesmentCollection
//
//  Created by Darren Hsu on 2019/8/3.
//  Copyright © 2019 D.H. All rights reserved.
//

import UIKit

class DHTableView: UITableView, DHAssesmentScroll, DHAssesmentMove, DHAssesmentInteractive{
    
    var viewDidScrollHorizontal: ((CGFloat) -> Void)?
    var viewDidScrollVertical: ((CGFloat) -> Void)?
    var viewDidMove: ((Int, Int) -> Void)?
    var beginInteractive: ((IndexPath) -> Void)?
    var updateInteractive: ((CGPoint) -> Void)?
    var cancelInteractive: (() -> Void)?
    var endInteractive: (() -> Void)?
    
    var layout: DhAssesmentLayout?
    var itemGroup: [[DHAssesmentItem]]?
    
    var collectionViews: [DHCollectionView] = []
    var scrollToX: CGFloat = 0
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.dataSource = self
        self.delegate = self
        
        self.register(DHTableViewCell.self, forCellReuseIdentifier: DHTableViewCell.id)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.dataSource = self
        self.delegate = self
        
        self.register(DHTableViewCell.self, forCellReuseIdentifier: DHTableViewCell.id)
    }
    
    func reloadData(_ layout: DhAssesmentLayout, itemGroup: [[DHAssesmentItem]]?) {
        self.layout = layout
        self.itemGroup = itemGroup
        
        self.separatorStyle = .none
        self.separatorInset = UIEdgeInsets.zero
        self.backgroundColor = UIColor.clear
        
        self.reloadData()
    }
    
    func scrollHorizontal(_ x: CGFloat) {
        self.scrollToX = x
        self.collectionViews.forEach { (collectionView) in
            collectionView.scrollRectToVisible(CGRect(x: x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height), animated: false)
        }
    }
    
    func beginInteractiveAll(_ indexPath: IndexPath) {
        self.collectionViews.forEach { (collectionView) in
            collectionView.beginInteractiveMovementForItem(at: indexPath)
        }
    }
    
    func updateInteractiveAll(_ point: CGPoint) {
        self.collectionViews.forEach { (collectionView) in
            collectionView.updateInteractiveMovementTargetPosition(point)
        }
    }
    
    func endInteractiveAll() {
        self.collectionViews.forEach { (collectionView) in
            collectionView.endInteractiveMovement()
        }
    }
    
    func cancelInteractiveAll() {
        self.collectionViews.forEach { (collectionView) in
            collectionView.cancelInteractiveMovement()
        }
    }
    
    deinit {
        print("\(String(describing: type(of: self))) deinit")
    }
}

extension DHTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemGroup?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DHTableViewCell.id, for: indexPath) as! DHTableViewCell
        
        return cell
    }
}

extension DHTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.layout?.displayCellHeight ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let collectionView = (cell as! DHTableViewCell).collectionView else { return }
        collectionView.reloadData(self.layout!, items: self.itemGroup![indexPath.row], collectionType: .display)
        collectionView.viewDidScrollHorizontal = {[weak self] (x) in
            self?.viewDidScrollHorizontal?(x)
            self?.scrollHorizontal(x)
        }
        self.collectionViews.append(collectionView)
        collectionView.scrollRectToVisible(CGRect(x: scrollToX, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height), animated: false)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let index = self.collectionViews.firstIndex(of: (cell as! DHTableViewCell).collectionView!) else { return }
        self.collectionViews.remove(at: index)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.viewDidScrollVertical?(scrollView.contentOffset.y)
    }
}
