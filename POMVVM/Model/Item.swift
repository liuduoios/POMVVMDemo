//
//  Item.swift
//  POMVVM
//
//  Created by 刘铎 on 15/12/7.
//  Copyright © 2015年 liuduoios. All rights reserved.
//

import Foundation
import Bond

struct Item {
    var itemID: String = NSUUID().UUIDString
    var currentDate: Observable<String?> = Observable(nil)
    var switchStatus: Observable<Bool> = Observable(false)
    
    init(currentDate: String, status: Bool) {
        self.currentDate = Observable(currentDate)
        self.switchStatus = Observable(status)
    }
}

extension Item: CustomDebugStringConvertible {
    var debugDescription: String {
        return "on = \(currentDate.value)"
    }
}

func == (lhs: Item, rhs: Item) -> Bool {
    return lhs.itemID == rhs.itemID
}

extension Item: Equatable {}