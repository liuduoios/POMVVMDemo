//
//  DateCellViewModel.swift
//  POMVVM
//
//  Created by 刘铎 on 15/12/10.
//  Copyright © 2015年 liuduoios. All rights reserved.
//

import Foundation
import Bond

struct DateCellViewModel: DateCellDataSource {
    
    // -------------------------
    // MARK: - Public Properties
    // -------------------------
    
    private(set) var dateText: Observable<String?> = Observable(nil)
    var switchOn: Observable<Bool> = Observable(false)
    
    // ------------------------
    // MARK: - Underlying Model
    // ------------------------
    
    private var item: Item {
        didSet {
            configureBinding()
        }
    }
    
    // Model和ViewModel之间的绑定
    private func configureBinding() {
        item.currentDate --> dateText
        item.switchStatus <==> switchOn
    }
    
    // -----------------
    // MARK: - Lifecycle
    // -----------------
    
    init(item: Item) {
        self.item = item
        configureBinding()
    }
}

// 符合Switchable协议，即已经实现了DetailViewControllerBusinessDelegate中要求的方法
extension DateCellViewModel: DateCellBusinessAction {}

extension DateCellViewModel: ViewModel {}
