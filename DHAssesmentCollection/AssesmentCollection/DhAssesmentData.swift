//
//  DhAssesmentData.swift
//  DHAssesmentCollection
//
//  Created by Darren Hsu on 2019/7/15.
//  Copyright © 2019 D.H. All rights reserved.
//

import UIKit

struct DhAssesmentData {
    var leftHeaders: [DhAssesmentItem]!
    var rightHeaders: [DhAssesmentItem]!
    var leftDisplays: [[DhAssesmentItem]]!
    var rightDisplays: [[DhAssesmentItem]]!
    
    mutating func changeItem(from: Int, to: Int) {
        self.rightHeaders?.changeItem(from: from, to: to)
        var displayGroup: [[DhAssesmentItem]] = []
        self.rightDisplays.forEach { (displays) in
            var d = displays
            d.changeItem(from: from, to: to)
            displayGroup.append(d)
        }
        self.rightDisplays = displayGroup
    }
}

struct DhAssesmentItem {
    var value: String?
    var textAlignment: NSTextAlignment?
    var width: CGFloat?
    var items: [DhAssesmentItem]?
    
    init(value: String? = nil,
        textAlignment: NSTextAlignment? = nil,
        width: CGFloat? = nil,
        items: [DhAssesmentItem]? = nil) {
        
        self.value = value
        self.width = width
        self.textAlignment = textAlignment
        self.items = items
    }
    
    mutating func append(_ item: DhAssesmentItem) {
        if items == nil {
            self.items = []
            self.items?.append(item)
            self.setWidth(item.width ?? 0)
        }else {
            self.items?.append(item)
            self.setWidth((self.width ?? 0) + (item.width ?? 0))
        }
    }
    
    mutating func setWidth(_ width: CGFloat) {
        self.width = width
    }
}

extension DhAssesmentData {
    static func mockData1() -> DhAssesmentData {
        let leftHeaders = [
            DhAssesmentItem(value: "產品代號", textAlignment: .center, width: 150.0),
            DhAssesmentItem(value: "商品名稱", textAlignment: .center, width: 150.0)
        ]
        
        var rightHeaders: [DhAssesmentItem] = []
        
        var rightDisplays: [[DhAssesmentItem]] = [], leftDisplays: [[DhAssesmentItem]] = []
        
        let rightHeaderCount = 20
        let displayCount = 100
        
        for i in 0..<displayCount {
            leftDisplays.append([])
            for j in 0..<leftHeaders.count {
                leftDisplays[i].append(DhAssesmentItem(value: "L \(j) \(i)", textAlignment: .center, width: 150.0))
            }
        }
        
        for i in 0..<rightHeaderCount {
            switch i {
            case 1, 3, 5, 7, 10 , 15, 18:
                var header = DhAssesmentItem(value: "H \(i)", textAlignment: .center)
                header.append(DhAssesmentItem(value: "H \(i).0", textAlignment: .center, width: 150))
                header.append(DhAssesmentItem(value: "H \(i).1", textAlignment: .center, width: 150))
                header.append(DhAssesmentItem(value: "H \(i).2", textAlignment: .center, width: 150))
                rightHeaders.append(header)
            default:
                rightHeaders.append(DhAssesmentItem(value: "H \(i)", textAlignment: .center, width: 150))
            }
        }
        
        for i in 0..<displayCount {
            rightDisplays.append([])
            for j in 0..<rightHeaders.count {
                if rightHeaders[j].items != nil {
                    var display = DhAssesmentItem()
                    for k in 0..<rightHeaders[j].items!.count {
                        display.append(DhAssesmentItem(value: "R \(j).\(k).\(i)", textAlignment: .right, width: 150))
                    }
                    rightDisplays[i].append(display)
                }else {
                    rightDisplays[i].append(DhAssesmentItem(value: "R \(j).\(i)", textAlignment: .right, width: 150))
                }
            }
        }
        
        return DhAssesmentData(leftHeaders: leftHeaders,
                               rightHeaders: rightHeaders,
                               leftDisplays: leftDisplays,
                               rightDisplays: rightDisplays)
    }
}
