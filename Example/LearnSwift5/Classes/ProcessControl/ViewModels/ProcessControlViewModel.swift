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
                          "repeat-while",
                          "for",
                          "for-in-array",
                          "RangeTypes"]
    
    private let funNames = ["use_if_else",
                            "use_while",
                            "use_repeat_while",
                            "use_for",
                            "use_for_in_array",
                            "use_range_types"]
    
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
        let condition = "age = 4" + newLine
        
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
            resultLog += "num is \(num)" + newLine
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
            resultLog += "num is \(num)" + newLine
        } while num > 0 // 打印1次
        
        logTV?.text = resultLog
    }
    
    // for
    @objc fileprivate func use_for() {
        // 闭区间运算符：a...b，a<= 取值 <= b
        resultLog = "闭区间运算符：a...b，a<= 取值 <= b" + newLine

        let names = ["Anna", "Alex", "Brian", "Jack"]
        resultLog += "names = \(names)" + newLine
        
        resultLog += newLine + "for i in 0...3" + newLine
        for i in 0...3 {
            resultLog += names[i] + " "
        } // Anna Alex Brian Jack
        
        resultLog += newLine + newLine + "let range = 1...3" + newLine
        let range = 1...3
        
        resultLog += "for i in range" + newLine
        for i in range {
            resultLog += (names[i] + " ")
        } // Alex Brian Jack
        
        let a = 1
        let b = 2
        
        resultLog += newLine + newLine + "a = 1" + newLine + "b = 2" + newLine + "for i in a...b" + newLine
        for i in a...b {
            resultLog += "\(names[i]) "
        } // Alex Brian
        
        resultLog += newLine + newLine + "for i in a...3" + newLine
        for i in a...3 {
            resultLog += "\(names[i]) "
        } // Alex Brian Jack
        
        resultLog += newLine + newLine + "for var i in 1...3" + newLine
        // i默认是let，有需要时可以声明为var
        for var i in 1...3 {
            i += 5
            resultLog += "\(i) "
        } // 6 7 8
        
        resultLog += newLine + newLine + "for _ in 1...3" + newLine
        for _ in 1...3 {
            resultLog += "for "
        } // 打印了3次
        
        // 半开区间运算符：a..b，a <= 取值 < b
        resultLog += newLine + newLine + "半开区间运算符：a..b，a <= 取值 < b" + newLine
        
        resultLog += "for i in 1..<5 " + newLine
        for i in 1..<5 {
            resultLog += "\(i) "
        } // 1 2 3 4
        
        logTV?.text = resultLog
    }
    
    /// for-区间运算符用在数组上
    @objc fileprivate func use_for_in_array() {
        resultLog = "for-区间运算符用在数组上" + newLine
        
        let names = ["Anna", "Alex", "Brian", "Jack"]
        resultLog += "names = \(names)" + newLine
        
        resultLog += newLine + "for i in 0...3" + newLine
        for i in 0...3 {
            resultLog += names[i] + " "
        } // Anna Alex Brian Jack
        
        // 单侧区间：让区间朝一个方向尽可能的远
        resultLog += newLine + newLine + "单侧区间：让区间朝一个方向尽可能的远" + newLine
        
        resultLog += "for name in names[2...]" + newLine
        for name in names[2...] {
            resultLog += "\(name) "
        } // Brian Jack
        
        resultLog += newLine + newLine + "for name in names[...2]" + newLine
        for name in names[...2] {
            resultLog += "\(name) "
        } // Anna Alex Brian
        
        resultLog += newLine + newLine + "for name in names[..<2]" + newLine
        for name in names[..<2] {
            resultLog += "\(name) "
        } // Anna Alex
        
        logTV?.text = resultLog
    }
    
    /// 区间类型
    @objc fileprivate func use_range_types() {

        let range1: ClosedRange<Int> = 1...3
        let range2: Range<Int> = 1..<3
        let range3: PartialRangeThrough<Int> = ...5
        
        // 字符、字符串也能使用区间运算符，但默认不能用for-in中
        let stringRange1 = "cc"..."ff" // ClosedRange<String>
        stringRange1.contains("cb") // false
        stringRange1.contains("dz") // false
        stringRange1.contains("fg") // false

        let stringRange2 = "a"..."f"
        stringRange2.contains("d") // true
        stringRange2.contains("h") // false
        
        // \0到~囊括了所有可能要用到的ASCII字符
        let characterRange: ClosedRange<Character> = "\0"..."~"
        characterRange.contains("G") // true
        
        logTV?.text = "阅读源码了解区间类型的使用"
    }
    
}



