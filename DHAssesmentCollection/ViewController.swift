//
//  ViewController.swift
//  DHAssesmentCollection
//
//  Created by Darren Hsu on 2019/7/13.
//  Copyright © 2019 D.H. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var contentView: DHAssesmentCollectionView!
    
    var data: DHAssesmentData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.data = DHAssesmentData.stupData1()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let d = data {
            var layout = DhAssesmentLayout()
            layout.headerHeight = layout.headerHeight * 2
            
            contentView.reloadData(d, layout: layout, didMoveItem: { [weak self] (from, to) in
                self?.data?.changeItem(from: from, to: to)
            })
        }
    }
}

