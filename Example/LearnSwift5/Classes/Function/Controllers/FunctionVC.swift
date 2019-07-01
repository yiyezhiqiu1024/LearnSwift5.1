//
//  FunctionVC.swift
//  LearnSwift5
//
//  Created by CoderSLZeng on 2019/7/1.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

import UIKit

class FunctionVC: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logTV: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lazy
    lazy var functionVM = FunctionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        functionVM.bindView(tableView)
        functionVM.bindView(titleLabel)
        functionVM.bindView(logTV)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
