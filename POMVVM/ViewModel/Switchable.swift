//
//  Switchable.swift
//  POMVVM
//
//  Created by 刘铎 on 15/12/10.
//  Copyright © 2015年 liuduoios. All rights reserved.
//

import Foundation
import Bond

/**
 *  抽取公共业务逻辑到单独Protocol中，并给出默认实现，来实现代码复用
 */
protocol Switchable {
    mutating func openSwitch()
    mutating func closeSwitch()
}

extension ViewModel where Self: Switchable {
    func openSwitch() {
        print("I have opend the switch.")
    }
    
    func closeSwitch() {
        print("I have closed the switch.")
    }
}
