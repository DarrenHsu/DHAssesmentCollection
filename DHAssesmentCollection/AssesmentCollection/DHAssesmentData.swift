//
//  DHAssesmentData.swift
//  DHAssesmentCollection
//
//  Created by Darren Hsu on 2019/7/15.
//  Copyright © 2019 D.H. All rights reserved.
//

import UIKit

struct DHAssesmentData {
    var leftHeaders: [DHAssesmentItem]!
    var rightHeaders: [DHAssesmentItem]!
    var leftDisplays: [[DHAssesmentItem]]!
    var rightDisplays: [[DHAssesmentItem]]!
    
    mutating func changeItem(from: Int, to: Int) {
        self.rightHeaders?.changeItem(from: from, to: to)
        var displayGroup: [[DHAssesmentItem]] = []
        self.rightDisplays.forEach { (displays) in
            var d = displays
            d.changeItem(from: from, to: to)
            displayGroup.append(d)
        }
        self.rightDisplays = displayGroup
    }
}

protocol DHItem {
    var value: String? { get set }
    var textAlignment: NSTextAlignment? { get set }
    var width: CGFloat? { get set }
    var items: [DHAssesmentItem]? { get set }
    
    init(value: String?, textAlignment: NSTextAlignment?, width: CGFloat?, items: [DHAssesmentItem]?)
}

struct DHAssesmentItem: DHItem {
    var value: String?
    var textAlignment: NSTextAlignment?
    var width: CGFloat?
    var items: [DHAssesmentItem]?
    
    init(value: String? = nil,
         textAlignment: NSTextAlignment? = nil,
         width: CGFloat? = nil,
         items: [DHAssesmentItem]? = nil) {
        
        self.value = value
        self.width = width
        self.textAlignment = textAlignment
        self.items = items
    }
    
    mutating func append(_ value: String? = nil, textAlignment: NSTextAlignment? = nil, width: CGFloat? = nil) {
        let item = DHAssesmentItem(value: value, textAlignment: textAlignment, width: width)
        self.append(item)
    }
    
    mutating func append(_ value: String? = nil, textAlignment: NSTextAlignment? = nil, width: Int? = nil) {
        let item = DHAssesmentItem(value: value, textAlignment: textAlignment, width: width != nil ? CGFloat(width!) : nil)
        self.append(item)
    }
    
    mutating func append(_ item: DHAssesmentItem) {
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

extension Array where Element: DHItem  {
    mutating func changeItem(from: Int, to: Int) {
        guard from != to else { return }
        precondition(from != to && indices.contains(from) && indices.contains(to), "invalid indexes")
        insert(remove(at: from), at: to)
    }
    
    mutating func append(_ value: String? = nil, textAlignment: NSTextAlignment? = nil, width: CGFloat? = nil, items: [Element]? = nil) {
        self.append(Element.init(value: value, textAlignment: textAlignment, width: width, items: nil))
    }
    
    mutating func append(_ value: String? = nil, textAlignment: NSTextAlignment? = nil, width: Int? = nil, items: [Element]? = nil) {
        self.append(Element.init(value: value, textAlignment: textAlignment, width: (width != nil ? CGFloat(width!) : nil), items: nil))
    }
}

extension DHAssesmentData {
    static func mockData1() -> DHAssesmentData {
        let leftHeaders = [
            DHAssesmentItem(value: "產品代號", textAlignment: .center, width: 80.0),
            DHAssesmentItem(value: "商品名稱", textAlignment: .center, width: 80.0)
        ]
        
        var rightHeaders: [DHAssesmentItem] = []
        
        var rightDisplays: [[DHAssesmentItem]] = [], leftDisplays: [[DHAssesmentItem]] = []
        
        let rightHeaderCount = 20
        let displayCount = 100
        
        for i in 0..<displayCount {
            leftDisplays.append([])
            for j in 0..<leftHeaders.count {
                leftDisplays[i].append(DHAssesmentItem(value: "L \(j) \(i)", textAlignment: .center, width: 80))
            }
        }
        
        for i in 0..<rightHeaderCount {
            switch i {
            case 2, 3:
                var header = DHAssesmentItem(value: "H \(i)", textAlignment: .center)
                header.append(DHAssesmentItem(value: "H \(i).0", textAlignment: .center, width: 280))
                header.append(DHAssesmentItem(value: "H \(i).1", textAlignment: .center, width: 280))
                rightHeaders.append(header)
            case 4:
                var header = DHAssesmentItem(value: "H \(i)", textAlignment: .center)
                header.append(DHAssesmentItem(value: "H \(i).0", textAlignment: .center, width: 280))
                header.append(DHAssesmentItem(value: "H \(i).1", textAlignment: .center, width: 280))
                header.append(DHAssesmentItem(value: "H \(i).2", textAlignment: .center, width: 280))
                rightHeaders.append(header)
            case 5:
                var header = DHAssesmentItem(value: "H \(i)", textAlignment: .center)
                header.append(DHAssesmentItem(value: "H \(i).0", textAlignment: .center, width: 280))
                header.append(DHAssesmentItem(value: "H \(i).1", textAlignment: .center, width: 280))
                header.append(DHAssesmentItem(value: "H \(i).2", textAlignment: .center, width: 280))
                header.append(DHAssesmentItem(value: "H \(i).2", textAlignment: .center, width: 280))
                header.append(DHAssesmentItem(value: "H \(i).2", textAlignment: .center, width: 280))
                rightHeaders.append(header)
            default:
                rightHeaders.append(DHAssesmentItem(value: "H \(i)", textAlignment: .center, width: 150))
            }
        }
        
        for i in 0..<displayCount {
            rightDisplays.append([])
            for j in 0..<rightHeaders.count {
                if rightHeaders[j].items != nil {
                    var display = DHAssesmentItem()
                    for k in 0..<rightHeaders[j].items!.count {
                        display.append(DHAssesmentItem(value: "R \(j).\(k).\(i)", textAlignment: .right, width: 280))
                    }
                    rightDisplays[i].append(display)
                }else {
                    rightDisplays[i].append(DHAssesmentItem(value: "R \(j).\(i)", textAlignment: .right, width: 150))
                }
            }
        }
        
        return DHAssesmentData(leftHeaders: leftHeaders,
                               rightHeaders: rightHeaders,
                               leftDisplays: leftDisplays,
                               rightDisplays: rightDisplays)
    }
}
