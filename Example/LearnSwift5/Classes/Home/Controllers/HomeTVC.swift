//
//  HomeTVC.swift
//  LearnSwift5
//
//  Created by CoderSLZeng on 2019/6/28.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

import UIKit

class HomeTVC: UITableViewController {
    
    // MARK: - properties
    lazy var homeVM = HomeViewModel()
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "LearnSwift5.1"
        homeVM.bindView(tableView)
    }
}


