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
    var itemID: String?
    var text: Observable<String?> = Observable(nil)
    var on: Observable<Bool> = Observable(false)
    
    init() {
        
    }
    
    init(text: String, on: Bool) {
        self.text = Observable(text)
        self.on = Observable(on)
    }
}

extension Item: CustomDebugStringConvertible {
    var debugDescription: String {
        return "on = \(on.value)"
    }
}