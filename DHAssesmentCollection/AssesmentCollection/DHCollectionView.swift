//
//  DHCollectionView.swift
//  DHAssesmentCollection
//
//  Created by Darren Hsu on 2019/7/16.
//  Copyright © 2019 D.H. All rights reserved.
//

import UIKit

protocol DHAssesmentScroll {
    var viewDidScrollHorizontal: ((CGFloat) -> Void)? { get set }
    var viewDidScrollVertical: ((CGFloat) -> Void)? { get set }
}

protocol DHAssesmentTap {
    var viewDidTwipleTap: ((Int) -> Void)? { get set }
}

protocol DHAssesmentMove {
    var viewDidMove: ((Int, Int) -> Void)? { get set }
}

protocol DHAssesmentInteractive {
    var beginInteractive: ((IndexPath) -> Void)? { get set }
    var updateInteractive: ((CGPoint) -> Void)? { get set }
    var endInteractive: (() -> Void)? { get set }
    var cancelInteractive: (() -> Void)? { get set }
}

class DHCollectionView: UICollectionView, DHAssesmentScroll, DHAssesmentMove, DHAssesmentTap, DHAssesmentInteractive {
    
    var viewDidScrollHorizontal: ((CGFloat) -> Void)?
    var viewDidScrollVertical: ((CGFloat) -> Void)?
    var viewDidMove: ((Int, Int) -> Void)?
    var viewDidTwipleTap: ((Int) -> Void)?
    var beginInteractive: ((IndexPath) -> Void)?
    var updateInteractive: ((CGPoint) -> Void)?
    var cancelInteractive: (() -> Void)?

    var startMoveIndex: Int?
    var endMoveIndex: Int?
    var layout: DhAssesmentLayout?
    var items: [DHAssesmentItem]?
    
    private var moveY: CGFloat?
    
    @objc var endInteractive: (() -> Void)?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupLongGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:)))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLongGesture2Second(_:)))
        tapGesture.numberOfTapsRequired = 3
        
        self.addGestureRecognizer(tapGesture)
        self.addGestureRecognizer(longPress)
    }
    
    @objc private func handleLongGesture2Second(_ gesture: UILongPressGestureRecognizer) {
        let state = gesture.state
        switch state {
        case .ended:
            let point = gesture.location(in: self)
            if let indexPath = self.indexPathForItem(at: point) {
                self.viewDidTwipleTap?(indexPath.row)
            }
        default: break
        }
    }
    
    @objc private func handleLongGesture(_ gesture: UILongPressGestureRecognizer) {
        let state = gesture.state
        switch state {
        case .began:
            let point = CGPoint(x: gesture.location(in: self).x, y: 0)
            if let indexPath = self.indexPathForItem(at: point) {
                let cell = self.cellForItem(at: indexPath)
                cell?.alpha = DHCollectionViewFlowLayout.movingAlpha
                
                self.moveY = (cell?.frame.size.height ?? 0.0) / 2.0
                self.beginInteractiveMovementForItem(at: indexPath)
                self.beginInteractive?(indexPath)
            }
        case .changed:
            let point = CGPoint(x: gesture.location(in: self).x, y: self.moveY ?? 0)
            self.updateInteractiveMovementTargetPosition(point)
            self.updateInteractive?(point)
        case .ended:
            self.endInteractive?()
            self.endInteractiveMovement()
        default:
            self.cancelInteractive?()
            self.cancelInteractiveMovement()
            moveY = nil
        }
    }
    
    func changeItem(_ from: Int, to: Int) {
        self.items?.changeItem(from: from, to: to)
    }
}
