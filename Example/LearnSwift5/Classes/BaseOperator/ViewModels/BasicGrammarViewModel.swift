//
//  BasicGrammarViewModel.swift
//  LearnSwift5
//
//  Created by CoderSLZeng on 2019/6/28.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

import UIKit

class BasicGrammarViewModel: NSObject, ViewModelProtocol {
    // MARK: - Properties
    private var titleLabel : UILabel?
    private var logTV: UITextView?
    private let titles = ["常量的使用",
                          "变量的使用",
                          "标识符的使用",
                          "整数类型的使用",
                          "浮点类型的使用"]
    
    private let funNames = ["use_constant",
                            "use_variable",
                            "use_🐂🍺",
                            "use_IntTypes",
                            "use_FloatAndDoubleTypes"]
    
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
extension BasicGrammarViewModel: UITableViewDataSource {
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
extension BasicGrammarViewModel: UITableViewDelegate {
    
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
extension BasicGrammarViewModel {
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
    
    // MARK: - 常见数据类型
    /// 整数类型的使用
    @objc fileprivate func use_IntTypes() {
        /// 有符号
        let int8: Int8 = -8
        let int16: Int16 = -16
        let int32: Int32 = -32
        let int64: Int64 = -64
        
        /// 无符号
        let uint8: UInt8 = 8
        let uint16: UInt16 = 16
        let uint32: UInt32 = 32
        let uint64: UInt64 = 64
        
        /// 在32bit平台，Int等价于Int32, Int等价于Int64
        // 整数的最值
        let maxUInt8 = UInt8.max
        let minInt16 = Int16.min
        
        /// 一般情况下，都是直接使用Int即可
        let int = 10
        
        logTV?.text = "Int8 = \(int8)\nInt16 = \(int16)\nInt32 = \(int32)\nInt64 = \(int64)\n\nUInt8 = \(uint8)\nUInt16 = \(uint16)\nUInt32 = \(uint32)\nUInt64 = \(uint64)\n\nUInt8的最大值 = \(maxUInt8)\nInt16的最小值 = \(minInt16)\n\n一般情况下，都是直接使用Int即可\n Int = \(int)"
    }
    
    /// 浮点类型的使用
    @objc fileprivate func use_FloatAndDoubleTypes() {
        // Float: 32位，精度只有6位
        let float: Float = 10.0
        
        // Double: 64位，精度至少15位
        let double: Double = 10.0
        
        logTV?.text = "Float: 32位，精度只有6位\nFloat = \(float)\n\nDouble: 64位，精度至少15位\nDouble = \(double)"
    }
    
}
