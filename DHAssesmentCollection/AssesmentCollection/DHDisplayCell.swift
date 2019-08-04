//
//  DHDisplayCell.swift
//  DHAssesmentCollection
//
//  Created by Darren Hsu on 2019/7/15.
//  Copyright © 2019 D.H. All rights reserved.
//

import UIKit

class DHDisplayCell: UICollectionViewCell {
    static let id = "DHDisplayCell"
    
    private var displayCollectionView: DHDisplayCollectionView!
    private var displayCollectionViewHightConstraint: NSLayoutConstraint!
    
    private var displayTable: UITableView!
    private var displayTableHightConstraint: NSLayoutConstraint!
    
    private var header: DhAssesmentHeader?
    private var displays: [DhAssesmentDisplay]?
    
    private var layout: DhAssesmentLayout?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    func reloadData(_ layout: DhAssesmentLayout, header: DhAssesmentHeader) {
        self.layout = layout
        self.header = header
        self.displays = header.displays
        
        if header.headers == nil {
            self.displayTableHightConstraint.constant = self.bounds.height
            self.displayCollectionViewHightConstraint.constant = 0
            self.displayTable.reloadData()
        }else {
            self.displayTableHightConstraint.constant = 0
            self.displayCollectionViewHightConstraint.constant = self.bounds.height
            self.displayCollectionView.reloadData(self.layout!, headers: self.header!.headers!)
        }
    }
    
    private func setupUI() {
        self.displayCollectionView = DHDisplayCollectionView(frame: CGRect.zero, collectionViewLayout: DHCollectionViewFlowLayout.createHorizontalFlowLayout())
        self.addSubview(displayCollectionView)
        
        self.displayTable = UITableView(frame: CGRect.zero)
        self.displayTable.register(DHDisplayTableCell.self, forCellReuseIdentifier: DHDisplayTableCell.id)
        self.displayTable.dataSource = self
        self.displayTable.delegate = self
        self.displayTable.bounces = false
        self.displayTable.showsVerticalScrollIndicator = false
        self.displayTable.showsHorizontalScrollIndicator = false
        self.addSubview(self.displayTable)
        
        self.displayCollectionViewHightConstraint = NSLayoutConstraint(item: displayCollectionView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        
        self.displayCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint(item: displayCollectionView!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: displayCollectionView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: displayCollectionView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: displayCollectionView!, attribute: .bottom, relatedBy: .equal, toItem: displayTable!, attribute: .top, multiplier: 1, constant: 0),
            self.displayCollectionViewHightConstraint
            ])
        
        self.displayTableHightConstraint = NSLayoutConstraint(item: displayTable!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        
        self.displayTable.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint(item: displayTable!, attribute: .top, relatedBy: .equal, toItem: displayCollectionView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: displayTable!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: displayTable!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: displayTable!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            self.displayTableHightConstraint
            ])
    }
    
    deinit {
        print("deinit")
    }
}

extension DHDisplayCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displays?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DHDisplayTableCell.id, for: indexPath) as! DHDisplayTableCell
        
        let data = displays![indexPath.row]
        cell.valueLabel.text = data.value
        cell.valueLabel.font = layout?.displayFount
        cell.valueLabel.textAlignment = data.textAlignment
        
        return cell
    }
}

extension DHDisplayCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(layout?.displayCellHeight ?? 0)
    }
}

class DHDisplayTableCell: UITableViewCell {
    static let id = "DHDisplayTableCell"
    
    var valueLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupUI()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    private func setupUI() {
        self.valueLabel = UILabel(frame: CGRect.zero)
        self.valueLabel.numberOfLines = 0
        self.addSubview(valueLabel)
        
        self.valueLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint(item: valueLabel!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: valueLabel!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 5),
            NSLayoutConstraint(item: valueLabel!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -5),
            NSLayoutConstraint(item: valueLabel!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            ])
        
        self.selectionStyle = .none
    }
}
