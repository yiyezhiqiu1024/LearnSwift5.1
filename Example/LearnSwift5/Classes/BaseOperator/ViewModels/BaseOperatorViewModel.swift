//
//  BaseOperatorViewModel.swift
//  LearnSwift5
//
//  Created by CoderSLZeng on 2019/6/28.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

import UIKit

class BaseOperatorViewModel: NSObject, ViewModelProtocol {
    // MARK: - Properties
    private var titleLabel : UILabel?
    private var logTV: UITextView?
    private let titles = ["常量的使用",
                          "变量的使用",
                          "标识符的使用"]
    
    private let funNames = ["use_constant",
                            "use_variable",
                            "use_🐂🍺"]
    
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
extension BaseOperatorViewModel: UITableViewDataSource {
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
extension BaseOperatorViewModel: UITableViewDelegate {
    
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

// MARK: - 常量
extension BaseOperatorViewModel {
    /// 常量的使用
     @objc fileprivate func use_constant() {
        /// 只能赋值一次
        /// 直接赋值
        let age1 = 10
        
        /// 先定义，后赋值
        let age2: Int
        age2 = 20
        
        /// 函数返回值
        let age3 = getAge()
        
        logTV?.text = "age1 = \(age1)\n" + "age2 = \(age2)\n" + "age3 = \(age3)\n"
    }
    
    fileprivate func getAge() -> Int {
        return 30
    }
    
    /// 变量的使用
     @objc fileprivate func use_variable() {
        
        /// 直接赋值
        var age1 = 10
        
        /// 先定义，后赋值
        var age2: Int
        age2 = 20
        
        /// 函数返回值
        var age3 = getAge()
        
        let previousText = "原始的值：\n" + "age1 = \(age1)\n" + "age2 = \(age2)\n" + "age3 = \(age3)\n"
        
        /// 修改原始的值
        let temp = age1
        age1 = age2
        age2 = age3
        age3 = temp
        
        let afterText = "最终的值：\n" + "age1 = \(age1)\n" + "age2 = \(age2)\n" + "age3 = \(age3)\n"
        logTV?.text = previousText + afterText
    }
    
    /// 标识符的使用
    /// 标识符（比如常量名、变量名、函数名）几乎可以使用任何字符
    /// 标识符不能以数字开头，不能包含空白字符、制表符、箭头等特殊字符
    @objc fileprivate func use_🐂🍺() {
        let 👽 = "ET"
        let milk = "🥛"
        let text = 👽 + " like " + milk
        myLog(text)
        logTV?.text = text
    }
    
}
