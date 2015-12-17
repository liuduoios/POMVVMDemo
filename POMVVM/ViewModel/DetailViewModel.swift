//
//  DetailViewModel.swift
//  POMVVM
//
//  Created by 刘铎 on 15/12/9.
//  Copyright © 2015年 liuduoios. All rights reserved.
//

import Foundation
import Bond

// ---------------------------------------------
// MARK: - 数据源（DetailViewControllerDataSource）
// ---------------------------------------------

struct DetailViewModel: DetailViewControllerDataSource {
    
    // ------------------------
    // MARK: - Underlying Model
    // ------------------------
    
    private var item: Item {
        didSet {
            configureBinding()
        }
    }
    
    private func configureBinding() {
        item.currentDate <==> detailText
        item.switchStatus <==> detailSwitchOn
    }
    
    // -----------------------------------
    // MARK: - ViewModel Public Properties
    // -----------------------------------
    
    var detailText: Observable<String?> = Observable(nil)
    var detailSwitchOn: Observable<Bool> = Observable(false)
    
    init(item: Item) {
        self.item = item
        configureBinding()
    }
}

// 符合Switchable协议，即已经实现了DetailViewControllerBusinessDelegate中要求的方法
extension DetailViewModel: DetailViewControllerBusinessAction {}

extension DetailViewModel: ViewModel {}
