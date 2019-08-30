//
//  DHAssesmentCollectionView.swift
//  DHAssesmentCollection
//
//  Created by Darren Hsu on 2019/7/15.
//  Copyright © 2019 D.H. All rights reserved.
//

import UIKit

class DHAssesmentCollectionView: UIView {
    
    private var assesmentData: DHAssesmentData?
    private var layout: DhAssesmentLayout?
    
    private var leftHeaderContrants: [NSLayoutConstraint] = []
    private var rightHeaderContrants: [NSLayoutConstraint] = []
    private var containerViewContrants: [NSLayoutConstraint] = []
    private var leftDisplayContrants: [NSLayoutConstraint] = []
    private var rightDisplayContrants: [NSLayoutConstraint] = []
    
    private var didMoveItem: ((Int, Int) -> Void)?
    private var containerHeight: CGFloat?
    private var didTwipleTapItem: ((Int) -> Void)?
    
    private lazy var leftHeader: DHItemGroupCollectionView = {
        var leftHeader = DHItemGroupCollectionView(frame: CGRect.zero, collectionViewLayout: DHCollectionViewFlowLayout.createHorizontalFlowLayout())
        leftHeader.backgroundColor = UIColor.clear
        leftHeader.bounces = false
        leftHeader.translatesAutoresizingMaskIntoConstraints = false
        return leftHeader
    }()
    
    private lazy var leftDisplay: DHTableView = {
        let leftDisplay = DHTableView(frame: .zero, style: .plain)
        leftDisplay.bounces = false
        leftDisplay.translatesAutoresizingMaskIntoConstraints = false
        leftDisplay.showsVerticalScrollIndicator = false
        leftDisplay.showsHorizontalScrollIndicator = false
        return leftDisplay
    }()
    
    private lazy var rightHeader: DHItemGroupCollectionView = {
        let rightHeader = DHItemGroupCollectionView(frame: .zero, collectionViewLayout: DHCollectionViewFlowLayout.createHorizontalFlowLayout())
        rightHeader.backgroundColor = UIColor.clear
        rightHeader.bounces = false
        rightHeader.translatesAutoresizingMaskIntoConstraints = false
        rightHeader.showsVerticalScrollIndicator = false
        rightHeader.showsHorizontalScrollIndicator = false
        rightHeader.setupLongGesture()
        return rightHeader
    }()
    
    private lazy var rightDisplay: DHTableView = {
        let rightDisplay = DHTableView(frame: .zero, style: .plain)
        rightDisplay.bounces = false
        rightDisplay.translatesAutoresizingMaskIntoConstraints = false
        rightDisplay.showsVerticalScrollIndicator = false
        rightDisplay.showsHorizontalScrollIndicator = false
        return rightDisplay
    }()
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupUI()
    }
    
    private func setupUI() {
        self.addSubview(leftHeader)
        self.addSubview(rightHeader)
        self.addSubview(leftDisplay)
        self.addSubview(rightDisplay)
        self.addSubview(indicatorView)
    }
    
    override func draw(_ rect: CGRect) {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: indicatorView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45),
            NSLayoutConstraint(item: indicatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45),
            NSLayoutConstraint(item: indicatorView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: indicatorView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
            ])
    }
    
    private func setupConstraint() {
        var lWidth: CGFloat = 0.0
        self.assesmentData?.leftHeaders.forEach {
            lWidth += $0.width ?? 0
        }
        
        self.removeConstraints(leftHeaderContrants)
        leftHeaderContrants = [
            NSLayoutConstraint(item: leftHeader, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: leftHeader, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: leftHeader, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: lWidth),
            NSLayoutConstraint(item: leftHeader, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(self.layout?.headerHeight ?? 0))
        ]
        self.addConstraints(leftHeaderContrants)
        
        self.removeConstraints(rightHeaderContrants)
        rightHeaderContrants = [
            NSLayoutConstraint(item: rightHeader, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightHeader, attribute: .leading, relatedBy: .equal, toItem: leftHeader, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightHeader, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightHeader, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(self.layout?.headerHeight ?? 0))
        ]
        self.addConstraints(rightHeaderContrants)
        
        self.removeConstraints(leftDisplayContrants)
        leftDisplayContrants = [
            NSLayoutConstraint(item: leftDisplay, attribute: .top, relatedBy: .equal, toItem: leftHeader, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: leftDisplay, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: leftDisplay, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: leftDisplay, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: lWidth)
        ]
        self.addConstraints(leftDisplayContrants)
        
        self.removeConstraints(rightDisplayContrants)
        rightDisplayContrants = [
            NSLayoutConstraint(item: rightDisplay, attribute: .top, relatedBy: .equal, toItem: rightHeader, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightDisplay, attribute: .leading, relatedBy: .equal, toItem: leftDisplay, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightDisplay, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightDisplay, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        ]
        self.addConstraints(rightDisplayContrants)
        
        self.layoutIfNeeded()
    }
    
    func reloadData(_ data: DHAssesmentData, layout: DhAssesmentLayout, didMoveItem: ((Int, Int) -> Void)? = nil, didTwipleTapItem: ((Int) -> Void)? = nil) {
        self.assesmentData = data
        self.layout = layout
        self.didMoveItem = didMoveItem
        self.didTwipleTapItem = didTwipleTapItem
        
        self.setupConstraint()
        self.setupData()
    }
    
    private func reloadData() {
        guard let layout = self.layout, let assesmentData = self.assesmentData else { return }
        
        self.leftHeader.reloadData(layout, items: assesmentData.leftHeaders)
        self.leftDisplay.reloadData(layout, itemGroup: assesmentData.leftDisplays)
        self.rightHeader.reloadData(layout, items: assesmentData.rightHeaders)
        self.rightDisplay.reloadData(layout, itemGroup: assesmentData.rightDisplays)
    }
    
    private func setupData() {
        if let lHeaders = assesmentData?.leftHeaders {
            self.leftHeader.reloadData(self.layout!, items: lHeaders)
        }
        
        if let lDisplays = assesmentData?.leftDisplays {
            self.leftDisplay.viewDidScrollVertical = {[weak self] (y: CGFloat) in
                self?.rightDisplay.scrollRectToVisible(CGRect(x: 0, y: y, width: self!.rightDisplay.bounds.size.width, height: self!.rightDisplay.bounds.size.height), animated: false)
            }
            self.leftDisplay.reloadData(self.layout!, itemGroup: lDisplays)
        }
        
        if let rHeaders = assesmentData?.rightHeaders {
            self.rightHeader.viewDidMove = {[weak self] (from: Int, to: Int) in
                self?.didMoveItem?(from, to)
                self?.assesmentData?.changeItem(from: from, to: to)
                self?.reloadData()
            }
            self.rightHeader.viewDidTwipleTap = {[weak self] (index) in
                self?.didTwipleTapItem?(index)
            }
            self.rightHeader.viewDidScrollHorizontal = {[weak self] (x) in
                self?.rightDisplay.scrollHorizontal(x)
            }
            self.rightHeader.beginInteractive = {[weak self] (indexPath: IndexPath) in
                self?.rightDisplay.beginInteractiveAll(indexPath)
            }
            self.rightHeader.updateInteractive = {[weak self] (point: CGPoint) in
                self?.rightDisplay.updateInteractiveAll(CGPoint(x: point.x, y: ((self!.layout?.displayCellHeight ?? 0)) / 2))
            }
            self.rightHeader.endInteractive = {[weak self] () in
                self?.rightDisplay.endInteractiveAll()
            }
            self.rightHeader.cancelInteractive = {[weak self] () in
                self?.rightDisplay.cancelInteractiveAll()
            }
            self.rightHeader.reloadData(self.layout!, items: rHeaders)
        }
        
        if let rDisplays = assesmentData?.rightDisplays {
            self.rightDisplay.viewDidScrollHorizontal = {[weak self] (x: CGFloat) in
                self?.rightHeader.scrollRectToVisible(CGRect(x: x, y: 0, width: self!.rightHeader.bounds.size.width, height: self!.rightHeader.bounds.size.height), animated: false)
            }
            self.rightDisplay.viewDidScrollVertical = {[weak self] (y: CGFloat) in
                self?.leftDisplay.scrollRectToVisible(CGRect(x: 0, y: y, width: self!.leftDisplay.bounds.size.width, height: self!.leftDisplay.bounds.size.height), animated: false)
            }
            self.rightDisplay.reloadData(self.layout!, itemGroup: rDisplays)
        }
        
        self.indicatorView.isHidden = true
        self.indicatorView.stopAnimating()
    }
}
