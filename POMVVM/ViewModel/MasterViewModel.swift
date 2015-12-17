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
    
    init() {
        items.observe { event in
            switch event.operation {
            case .Insert(let elements, _):
                for item in elements {
                    item.switchStatus.distinct().observeNew { on in
                        self.openSwitchCount.next(self.currentOpenSwitchCount())
                    }
                }
            case .Remove(_):
                self.openSwitchCount.next(self.currentOpenSwitchCount())
            default:
                break
            }
        }
    }
    
    private func currentOpenSwitchCount() -> Int {
        return items.array
            .filter { $0.switchStatus.value }
            .count
    }
}

// -----------------------------------------------------
// MARK: - 业务逻辑（MasterViewControllerBusinessDelegate）
// -----------------------------------------------------

extension MasterViewModel: MasterViewControllerBusinessAction {
    func insertNowDate() {
        let item = Item(currentDate: NSDate().description, status: false)
        items.insert(item, atIndex: 0)
    }
    
    func deleteRowAtIndex(index: Int) {
        items.removeAtIndex(index)
    }
}

extension MasterViewModel: ViewModel {}
