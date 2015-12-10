//
//  BindableView.swift
//  POMVVM
//
//  Created by 刘铎 on 15/12/6.
//  Copyright © 2015年 liuduoios. All rights reserved.
//

import UIKit

protocol BindableView {
    typealias ViewModelType
    var viewModel: ViewModelType! { get }
    func bindViewModel(viewModel: ViewModelType)
}
