//
//  MasterViewController.swift
//  POMVVM
//
//  Created by 刘铎 on 15/12/6.
//  Copyright © 2015年 liuduoios. All rights reserved.
//

import UIKit
import Bond


protocol MasterViewControllerDataSource {
    var items: ObservableArray<Item> { get }
    var openSwitchCount: Observable<Int> { get }
}

protocol MasterViewControllerBusinessDelegate {
    func insertNowDate()
    func openSwitchInCellAtRow(row: Int)
    func closeSwitchInCellAtRow(row: Int)
    func updateOpenSwitchCount()
}

class MasterViewController: UITableViewController, BindableView {
    
    typealias ViewModelType = protocol <MasterViewControllerDataSource, MasterViewControllerBusinessDelegate, ViewModel>
    var viewModel: ViewModelType!
    func bindViewModel(viewModel: ViewModelType) {
        viewModel.items.lift().bindTo(tableView) { indexPath, dataSource, tableView in
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DateCell
            let item = dataSource[indexPath.section][indexPath.row]
            
            // 由于Swift中的数组是值类型，所以如果在cell中保存item，这个item实际上是拷贝了一份的item，和原数组没有任何关系
            // 因此，Cell只能纯粹用来展现数据，并且接收用户操作并回调给ViewController
            // Cell不能用来保存数据
            
            item.text.bindTo(cell.label.bnd_text)
            item.on.bidirectionalBindTo(cell.cellSwitch.bnd_on)
            
            item.on.distinct().observeNew({ (switchOn) -> Void in
                self.viewModel.updateOpenSwitchCount()
            })
            
            cell.cellSwitch.bnd_on.distinct().observeNew { switchOn in
                if switchOn {
                    viewModel.openSwitchInCellAtRow(indexPath.row)
                } else {
                    viewModel.closeSwitchInCellAtRow(indexPath.row)
                }
            }
            
            return cell
        }
        
        viewModel.openSwitchCount
            .distinct()
            .map { "共有 \($0) 个开关打开了" }
            .bindTo(headerLabel.bnd_text)
    }
    
    let headerLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: 40))
        label.text = "共有 0 个开关打开了"
        label.textAlignment = .Center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        viewModel = MasterViewModel()
        bindViewModel(viewModel)
        
        self.tableView.tableHeaderView = headerLabel
    }

    @objc private func insertNewObject(sender: AnyObject) {
        viewModel.insertNowDate()
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destinationViewController as! DetailViewController                
                
                // 取出viewModel.items中对应的Item，创建一个DetailViewModel
                
                let detailViewModel = DetailViewModel(item: viewModel.items[indexPath.row])
                controller.viewModel = detailViewModel
            }
        }
    }

}

