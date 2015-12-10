//
//  Switchable.swift
//  POMVVM
//
//  Created by 刘铎 on 15/12/10.
//  Copyright © 2015年 liuduoios. All rights reserved.
//

import Foundation
import Bond

protocol Switchable {
    var on: Observable<Bool> { get set }
    mutating func openSwitch()
    mutating func closeSwitch()
}

extension ViewModel where Self: Switchable {
    func openSwitch() {
        print("I have opened the switch.")
    }
    
    func closeSwitch() {
        print("I have closed the switch.")
    }
}
