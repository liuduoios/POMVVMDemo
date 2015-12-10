//
//  MasterViewModel.swift
//  POMVVM
//
//  Created by 刘铎 on 15/12/6.
//  Copyright © 2015年 liuduoios. All rights reserved.
//

import Foundation
import Bond

// ---------------------------------------------
// MARK: - 数据源（MasterViewControllerDataSource）
// ---------------------------------------------

struct MasterViewModel: MasterViewControllerDataSource {
    var items: ObservableArray<Item> = ObservableArray([Item]())
    var openSwitchCount: Observable<Int> = Observable(0)
}

// -----------------------------------------------------
// MARK: - 业务逻辑（MasterViewControllerBusinessDelegate）
// -----------------------------------------------------

extension MasterViewModel: MasterViewControllerBusinessDelegate {
    func insertNowDate() {
        let item = Item(text: NSDate().description, on: false)
        items.insert(item, atIndex: 0)
    }
    
    func updateOpenSwitchCount() {
        openSwitchCount.next(currentOpenSwitchCount())
    }
    
    private func currentOpenSwitchCount() -> Int {
        print(items.array)
        let count = items.array.filter { $0.on.value }.count
        return count
    }
}

extension MasterViewModel: ViewModel {}
