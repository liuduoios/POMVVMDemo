//
//  DateCell.swift
//  POMVVM
//
//  Created by 刘铎 on 15/12/6.
//  Copyright © 2015年 liuduoios. All rights reserved.
//

import UIKit
import Bond

//protocol DateCellDataSource {
//    var text: Observable<String?> { get }
//    var on: Observable<Bool> { get set }
//    var textColor: Observable<UIColor> { get }
//}
//
//extension DateCellDataSource {
//    var textColor: Observable<UIColor> {
//        return Observable(.greenColor())
//    }
//}
//
//protocol DateCellBusinessDelegate {
//    mutating func openSwitch()
//    mutating func closeSwitch()
//}

class DateCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var cellSwitch: UISwitch!
    
//    typealias ViewModelType = protocol <DateCellDataSource, DateCellBusinessDelegate, ViewModel>
//    var viewModel: ViewModelType!
//    func bindViewModel(var viewModel: ViewModelType) {
//        self.viewModel = viewModel
//        
//        bnd_bag.dispose()
//        
//        viewModel.text.bindTo(label.bnd_text)
//        viewModel.textColor.bindTo(label.bnd_textColor)
//        
//        viewModel.on.bidirectionalBindTo(cellSwitch.bnd_on)
//        
//        cellSwitch.bnd_on
//            .distinct()
//            .observeNew { switchOn in
//                if switchOn {
//                    viewModel.openSwitch()
//                } else {
//                    viewModel.closeSwitch()
//                }
//            }.disposeIn(bnd_bag)
//    }
//    
//    func unbindViewModel() {
//        bnd_bag.dispose()
//    }
}

