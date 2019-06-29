//
//  ProcessControlViewModel.swift
//  LearnSwift5
//
//  Created by Anthony on 2019/6/29.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

import UIKit

class ProcessControlViewModel: NSObject, ViewModelProtocol {
    
    // MARK: - Properties
    private var titleLabel : UILabel?
    private var logTV: UITextView?
    private let titles = ["if-else"]
    
    private let funNames = ["use_if_else"]
    
    // MARK: - Interface
    func bindView(_ bindView: UIView) {
        
        if bindView.isMember(of: UITableView.self) {
            let tableView = bindView as! UITableView
            tableView.dataSource = self
            tableView.delegate = self
            tableView.bounces = false
        }
        else if bindView.isMember(of: UILabel.self) {
            titleLabel = bindView as? UILabel
        } else if bindView.isMember(of: UITextView.self) {
            logTV = bindView as? UITextView
        }
    }
}

// MARK: - Table view data source
extension ProcessControlViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "HomeCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: identifier)
        }
        
        cell?.textLabel?.text = titles[indexPath.row]
        cell?.detailTextLabel?.text = funNames[indexPath.row]
        return cell!
    }
}

// MARK: - Table view delegate
extension ProcessControlViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        titleLabel?.text = titles[indexPath.row]
        let selectorName = funNames[indexPath.row]
        let aSelector = NSSelectorFromString(String(selectorName))
        perform(aSelector)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

// MARK: - 流程控制
extension ProcessControlViewModel {
    /// if-else
    @objc fileprivate func use_if_else() {
        var log = "if后面的条件只能是Bool类型\n"
        log += "if后面的条件可以省略小括号\n"
        log += "条件后面的大括号不可以省略\n"
        log += "age = 4\n"
        
        let age = 4
        if age >= 22 {
            log += "Get married"
        } else if age >= 18 {
            log += "Being a adult"
        } else if age >= 7 {
            log += "Go to school"
        } else {
            log += "Just a child"
        }
        
        logTV?.text = log
    }
}



