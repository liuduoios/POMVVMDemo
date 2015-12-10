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
    
    private(set) var text: Observable<String?> = Observable(nil)
    var on: Observable<Bool> = Observable(false)
    
    // ------------------------
    // MARK: - Underlying Model
    // ------------------------
    
    private var item: Item {
        didSet {
            configureBinding()
        }
    }
    
    private func configureBinding() {
        item.text.bidirectionalBindTo(text)
        item.on.bidirectionalBindTo(on)
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
extension DateCellViewModel: DateCellBusinessDelegate, Switchable {}

extension DateCellViewModel: ViewModel {}