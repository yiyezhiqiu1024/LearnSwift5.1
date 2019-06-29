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
    private let defalutLog = "尝试点击下方选项条，查看结果吧"
    private var resultLog = ""
    
    private let titles = ["if-else",
                          "while",
                          "repeat-while"]
    
    private let funNames = ["use_if_else",
                            "use_while",
                            "use_repeat_while"]
    
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
            logTV?.text = defalutLog
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
        /**
         if后面的条件只能是Bool类型
         if后面的条件可以省略小括号
         条件后面的大括号不可以省略
        */
        let condition = "age = 4\n"
        
        let age = 4
        if age >= 22 {
            resultLog = "Get married"
        } else if age >= 18 {
            resultLog = "Being a adult"
        } else if age >= 7 {
            resultLog = "Go to school"
        } else {
            resultLog = "Just a child"
        }
        
        logTV?.text = condition + resultLog
    }
    
    /// while
    @objc fileprivate func use_while() {
        
        resultLog = ""
        
        var num = 5
        while num > 0 {
            resultLog += "num is \(num)\n"
            num -= 1
        }
        
        logTV?.text = resultLog
    }
    
    /// repeat-while
    @objc fileprivate func use_repeat_while() {
        resultLog = ""
        
        let num = -1
        
        // repeate-whiel 相当于C语言中的 do-while
        // 这里不用num--，是因为
        // 从Swift3开始，去除了自增（++）、自减（--）运算符
        repeat {
            resultLog += "num is \(num)\n"
        } while num > 0 // 打印1次
        
        logTV?.text = resultLog
    }
}



