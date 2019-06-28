//
//  BaseOperatorTVC.swift
//  LearnSwift5
//
//  Created by CoderSLZeng on 2019/6/28.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

import UIKit

class BaseOperatorTVC: UITableViewController {
    
    // MARK: - properties
    lazy var baseOperatorVM = BaseOperatorViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        baseOperatorVM.bindViewModel(tableView)
    }
    
}



