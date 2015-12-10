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
    
    var item: Item {
        didSet {
            configure()
        }
    }
    
    private func configure() {
        item.text.bidirectionalBindTo(text)
        item.on.bidirectionalBindTo(on)
    }
    
    // -----------------------------------
    // MARK: - ViewModel Public Properties
    // -----------------------------------
    
    var text: Observable<String?> = Observable(nil)
    var on: Observable<Bool> = Observable(false)
    
    init(item: Item) {
        self.item = item
        configure()
    }
}

extension DetailViewModel: DetailViewControllerBusinessDelegate, Switchable {}

extension DetailViewModel: ViewModel {}
