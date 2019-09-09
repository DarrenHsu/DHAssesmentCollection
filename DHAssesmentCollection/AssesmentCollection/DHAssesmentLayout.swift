//
//  DhAssesmentLayout.swift
//  DHAssesmentCollection
//
//  Created by Darren Hsu on 2019/7/16.
//  Copyright © 2019 D.H. All rights reserved.
//

import UIKit

struct DhAssesmentLayout {
    var headerHeight: CGFloat = 45
    
    var headerBackgroundColor: UIColor = .white
    var headerFount: UIFont = UIFont.boldSystemFont(ofSize: 20)
    var headerTextAlignment: NSTextAlignment = .center
    
    var headerBorderWidth: CGFloat = 0.5
    var headerBorderColor: UIColor = .lightGray
    
    var headerFixSaparatorWidth: CGFloat = 0.5
    var headerFixSaparatorColor: UIColor = .lightGray
    var displayFixSaparatorWidth: CGFloat = 0.5
    var displayFixSaparatorColor: UIColor = .lightGray
    
    var displayFount: UIFont = UIFont.systemFont(ofSize: 17)
    var displayCellHeight: CGFloat = 50
    var displayCellBackgroundColor: UIColor = .white
    var displayCellSapartorBorderWidth: CGFloat = 0.5
    var displayCellSapartorBorderColor: UIColor = .lightGray
    
    var displayBorderWidth: CGFloat = 0
    var displayBorderColor: UIColor = .lightGray
}
