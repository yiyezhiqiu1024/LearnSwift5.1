//
//  BasicGrammarVC.swift
//  LearnSwift5
//
//  Created by CoderSLZeng on 2019/6/28.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

import UIKit

class BasicGrammarVC: UIViewController {

    // MARK: - properties
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logTV: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lazy
    lazy var baseOperatorVM = BasicGrammarViewModel()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        baseOperatorVM.bindView(tableView)
        baseOperatorVM.bindView(titleLabel)
        baseOperatorVM.bindView(logTV)
    }

}
