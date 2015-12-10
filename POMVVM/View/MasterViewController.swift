//
//  MasterViewController.swift
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

protocol MasterViewControllerDataSource {
    var items: ObservableArray<Item> { get }
    var openSwitchCount: Observable<Int> { get }
}

protocol MasterViewControllerBusinessDelegate {
    func insertNowDate()
    func updateOpenSwitchCount()
}

// -------------
// MARK: - Class
// -------------

class MasterViewController: UITableViewController, BindableView {
    
    // ------------------
    // MARK: - Properties
    // ------------------
    
    let headerLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: 40))
        label.text = "共有 0 个开关打开了"
        label.textAlignment = .Center
        return label
    }()
    
    // ---------------
    // MARK: - Actions
    // ---------------

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        self.tableView.tableHeaderView = headerLabel
        
        viewModel = MasterViewModel()
        bindViewModel(viewModel)
    }
    
    // ---------------
    // MARK: - Actions
    // ---------------

    @objc private func insertNewObject(sender: AnyObject) {
        viewModel.insertNowDate()
    }
    
    // ---------------------------
    // MARK: - 实现BindableView协议
    // ---------------------------
    
    typealias ViewModelType = protocol <MasterViewControllerDataSource, MasterViewControllerBusinessDelegate, ViewModel>
    
    var viewModel: ViewModelType!
    
    func bindViewModel(viewModel: ViewModelType) {
        // 把数据绑定到TableView上
        viewModel.items.lift().bindTo(tableView) { indexPath, dataSource, tableView in
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DateCell
            let item = dataSource[indexPath.section][indexPath.row]
            
            // 为每个cell绑定cellViewModel
            let cellViewModel = DateCellViewModel(item: item)
            cell.bindViewModel(cellViewModel)
            
            // 监听cell中开关的变化，来更新“打开开关的总个数”Label的显示内容
            item.on.distinct().observeNew { switchOn in
                self.viewModel.updateOpenSwitchCount()
            }
            
            return cell
        }
        
        // 把“打开开关的总个数”绑定到headerLabel上
        viewModel.openSwitchCount
            .distinct()
            .map { "共有 \($0) 个开关打开了" }
            .bindTo(headerLabel.bnd_text)
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

