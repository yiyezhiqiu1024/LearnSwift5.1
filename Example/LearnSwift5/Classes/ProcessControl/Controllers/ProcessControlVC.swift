//
//  ProcessControlVC.swift
//  LearnSwift5
//
//  Created by Anthony on 2019/6/29.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

import UIKit

class ProcessControlVC: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logTV: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lazy
    lazy var processControlVM = ProcessControlViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        processControlVM.bindView(tableView)
        processControlVM.bindView(titleLabel)
        processControlVM.bindView(logTV)
    }

}
