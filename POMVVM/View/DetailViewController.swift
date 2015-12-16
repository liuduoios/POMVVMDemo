//
//  DetailViewController.swift
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

protocol DetailViewControllerDataSource {
    var detailSwitchOn: Observable<Bool> { get set }
    var detailText: Observable<String?> { get set }
}

protocol DetailViewControllerBusinessAction: Switchable {}

// -------------
// MARK: - Class
// -------------

class DetailViewController: UIViewController, BindableView {
    
    // ------------------
    // MARK: - Properties
    // ------------------

    @IBOutlet weak var detailSwitch: UISwitch!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailTextField: UITextField!
    
    // ------------------
    // MARK: - Lifecycle
    // ------------------
    
    init(viewModel: ViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bindViewModel(viewModel)
    }
    
    // ---------------------------
    // MARK: - 实现BindableView协议
    // ---------------------------
    
    typealias ViewModelType = protocol <DetailViewControllerDataSource, DetailViewControllerBusinessAction, ViewModel>
    
    var viewModel: ViewModelType!
    
    func bindViewModel(viewModel: ViewModelType) {
        // ViewModel的text和TextField的text双向绑定
        viewModel.detailText <==> detailTextField.bnd_text
        
        // ViewModel的text单项绑定到Label上
        viewModel.detailText --> detailDescriptionLabel.bnd_text
        
        // ViewModel的on和UISwitch的on双向绑定
        viewModel.detailSwitchOn <==> detailSwitch.bnd_on
        
        detailSwitch.bnd_on.observeNew { switchOn in
            if switchOn {
                viewModel.openSwitch()
            } else {
                viewModel.closeSwitch()
            }
        }.disposeIn(bnd_bag)
    }
}

