//
//  DHLabel.swift
//  DHAssesmentCollection
//
//  Created by wen on 2019/8/8.
//  Copyright © 2019 D.H. All rights reserved.
//

import UIKit

class DHLabel: UILabel {
    
    private var isSetupLayout = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupUI()
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        super.drawText(in: rect.inset(by: insets))
    }
    
    func setupUI() {
        self.numberOfLines = 0
    }
    
    func setupLayout(_ layout: DhAssesmentLayout, type: DHItemCollectionViewType) {
        guard !isSetupLayout else { return }
        self.backgroundColor = type == .header ? layout.headerBackgroundColor : layout.displayCellBackgroundColor
        self.layer.borderColor = layout.headerBorderColor.cgColor
        self.layer.borderWidth = layout.headerBorderWidth
        self.font = type == .header ? layout.headerFount : layout.displayFount
        isSetupLayout = true
    }    
}
