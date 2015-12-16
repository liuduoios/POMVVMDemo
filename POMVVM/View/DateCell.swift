//
//  DateCell.swift
//  POMVVM
//
//  Created by 刘铎 on 15/12/6.
//  Copyright © 2015年 liuduoios. All rights reserved.
//

import UIKit
import Bond

// ----------------
// MARK: - Protocol
// ----------------

protocol DateCellDataSource {
    var dateText: Observable<String?> { get }
    var switchOn: Observable<Bool> { get set }
    var textColor: Observable<UIColor> { get }
}

extension DateCellDataSource {
    /// 为textColor提供一种默认颜色
    var textColor: Observable<UIColor> {
        return Observable(.blueColor())
    }
}

protocol DateCellBusinessAction: Switchable {}

// -------------
// MARK: - Class
// -------------

class DateCell: UITableViewCell, BindableTableCell {
    
    // ------------------
    // MARK: - Properties
    // ------------------
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var cellSwitch: UISwitch!
    
    // --------------------------------
    // MARK: - 实现BindableTableCell协议
    // --------------------------------
    
    typealias ViewModelType = protocol <DateCellDataSource, DateCellBusinessAction, ViewModel>
    
    var viewModel: ViewModelType!
    
    func bindViewModel(var viewModel: ViewModelType) {
        self.viewModel = viewModel
        
        bnd_bag.dispose()
        
        // ViewModel中关于text的属性单向绑定到label的相关属性上
        viewModel.dateText --> label.bnd_text
        viewModel.textColor --> label.bnd_textColor
        
        // ViewModel的on和UISwitch的on单向绑定
        viewModel.switchOn <==> cellSwitch.bnd_on
        
        viewModel.switchOn.distinct().observeNew { on in
            if on {
                viewModel.openSwitch()
            } else {
                viewModel.closeSwitch()
            }
        }.disposeIn(bnd_bag)
    }
}

