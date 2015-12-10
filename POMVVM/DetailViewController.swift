//
//  DetailViewController.swift
//  POMVVM
//
//  Created by 刘铎 on 15/12/6.
//  Copyright © 2015年 liuduoios. All rights reserved.
//

import UIKit
import Bond

protocol DetailViewControllerDataSource {
    var on: Observable<Bool> { get set }
    var text: Observable<String?> { get set }
}

protocol DetailViewControllerBusinessDelegate {
    func openSwitch()
    func closeSwitch()
}

class DetailViewController: UIViewController, BindableView {

    @IBOutlet weak var detailSwitch: UISwitch!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailTextField: UITextField!
    
    typealias ViewModelType = protocol <DetailViewControllerDataSource, DetailViewControllerBusinessDelegate, ViewModel>
    var viewModel: ViewModelType!
    func bindViewModel(viewModel: ViewModelType) {
        viewModel.text.bidirectionalBindTo(detailDescriptionLabel.bnd_text)
        viewModel.on.bidirectionalBindTo(detailSwitch.bnd_on)
        detailDescriptionLabel.bnd_text.bidirectionalBindTo(detailTextField.bnd_text)
        
        detailSwitch.bnd_on.observeNew { switchOn in
            if switchOn {
                viewModel.openSwitch()
            } else {
                viewModel.closeSwitch()
            }
        }
    }
    
//    var itemID: String? {
//        didSet {
//            var item = Item()
//            item.itemID = itemID
//            self.viewModel = DetailViewModel(item: Item())
//        }
//    }
    
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
}

