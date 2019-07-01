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
    
    fileprivate enum Answer { case right, wrong }
    
    private let titles = ["if-else",
                          "while",
                          "repeat-while",
                          "for",
                          "for-in-array",
                          "RangeTypes",
                          "带间隔的区间值",
                          "switch",
                          "where",
                          "标签语句"]
    
    private let funNames = ["use_if_else",
                            "use_while",
                            "use_repeat_while",
                            "use_for",
                            "use_for_in_array",
                            "use_range_types",
                            "use_range_value_with_interval",
                            "use_switch",
                            "use_where",
                            "use_outer"]
    
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
        let identifier = "ProcessControlCell"
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
        if_else(age)
        
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
    
    // 带间隔的区间值
    @objc fileprivate func use_range_value_with_interval() {
        let hours = 11
        let hourInterval = 2
        // tickMark的取值：从4开始，累加2，不超过11
        for tickMark in stride(from: 4, to: hours, by: hourInterval) {
            resultLog += "\(tickMark)"
        }
        
        logTV?.text = resultLog
    }
    
    // switch
    @objc fileprivate func use_switch() {
    
        let number = 1
        
        // 1.默认
        switch_default(number)
        
        resultLog += newLine
        
        // 2.贯穿
        switch_fallthrough(number)
        
        /**
         注意点1.必须要保证能处理所有的情况
         
         case、default后面至少要有一条语句
         var number = 1
         switch number {
         case 1:
            print("number is 1")
         case 2:
            print("number is 2")
         }
         
         如果不想做任何事，加一个break即可
         var number = 1
         switch number {
         case 1:
            print("number is 1")
         case 2:
            print("number is 2")
         default:
            break
         }
         */
        
        resultLog += newLine
        
        // 3.枚举
        resultLog += newLine + "如果能保证已处理所有情况，也可以不必使用default" + newLine
        let answer = Answer.right
        switch_Enum(answer)
        
        resultLog += newLine
        
        // 4.字符或字符串
        resultLog += newLine + "复合条件：switch也支持Character、String 类型" + newLine
        switch_Character_String()
        
        resultLog += newLine
        
        // 5.区间匹配
        resultLog += newLine + "区间匹配" + newLine
        let count = 62
        switch_pattern_Range(count) // dozens of
        
        resultLog += newLine
        
        // 6.元组匹配
        resultLog += newLine + "元组匹配" + newLine
        let point1 = (1, 1)
        switch_pattern_Tuple(point1)
        
        resultLog += newLine
        
        // 7.值绑定
        resultLog += newLine + "值绑定" + newLine
        let point2 = (2, 0)
        switch_bind_value(point2)
        
        logTV?.text = resultLog
    }
    
    // where
    @objc fileprivate func use_where() {
        
        resultLog = "where by switch" + newLine
        let point = (1, -1)
        where_by_switch(point) // on the lin x == -y
        
        resultLog += newLine + newLine
        
        resultLog += "where by for" + newLine
        let numbers = [10, 20, -10, -20, 30, -30]
        where_by_for(numbers) // 60
        
        logTV?.text = resultLog
    }
    
    // 标签语句
    @objc fileprivate func use_outer() {
        resultLog = ""
        outer: for i in 1...4 {
            for k in 1...4 {
                if k == 3 {
                    continue outer
                }
                if i == 3 {
                    break outer
                }
                
                resultLog += "i == \(i), k == \(k)" + newLine
            }
        }
        logTV?.text = resultLog
    }
}

// MARK: - Use if else
extension ProcessControlViewModel {
    
    fileprivate func if_else(_ age: Int) {
        if age >= 22 {
            resultLog = "Get married"
        } else if age >= 18 {
            resultLog = "Being a adult"
        } else if age >= 7 {
            resultLog = "Go to school"
        } else {
            resultLog = "Just a child"
        }
    }
    
}

// MARK: - Use switch
extension ProcessControlViewModel {
    
    
    fileprivate func switch_default(_ number: Int) {
        resultLog = "case、default后面不能写大括号" + newLine
        resultLog += "默认可以不写break, 并不会贯穿到后面的条件" + newLine
        
        switch number {
        case 1:
            resultLog += "number is 1"
        case 2:
            resultLog += "number is 2"
        default:
            resultLog += "number is other"
        }
    }
    
    fileprivate func switch_fallthrough(_ number: Int) {
        resultLog += newLine + "使用fallthrough可以实现贯穿效果" + newLine
        
        switch number {
        case 1:
            resultLog += "number is 1" + newLine
            fallthrough
        case 2:
            resultLog += "number is 2"
        default:
            resultLog += "number is other"
        }
    }
    
    fileprivate func switch_Enum(_ answer: Answer) {
        // 注意点2.如果能保证已处理所有情况，也可以不必使用default
        switch answer {
        case Answer.right:
            resultLog += "right"
        case .wrong: // 由于已确定answer是Answer类型，因此可以省略Answer
            resultLog += "wrong"
        }
    }
    
    fileprivate func switch_Character_String() {
        // 复合条件：switch也支持Character、String 类型
        let character: Character = "a"
        switch character {
        case "a", "A":
            resultLog += "The letter A"
        default:
            resultLog += "Not the letter A"
        } // The letter A
        
        resultLog += newLine
        
        let string = "Jack"
        switch string {
        case "Jack":
            fallthrough
        case "Rose":
            resultLog += "Right person"
        default:
            break
        } // Right person
    }
    
    
    fileprivate func switch_pattern_Range(_ count: Int) {
        switch count {
        case 0:
            resultLog += "none"
        case 1..<5:
            resultLog += "a few"
        case 5..<12:
            resultLog += "several"
        case 12..<100:
            resultLog += "dozens of"
        case 100..<1000:
            resultLog += "hundreds of"
            
        default:
            resultLog += "many"
        }
    }
    
    fileprivate func switch_pattern_Tuple(_ point: (Int, Int)) {
        // 可以使用下划线_ 忽略某个值
        switch point {
        case (0, 0):
            resultLog += "the origin"
        case (_, 0):
            resultLog += "on the x-axis"
        case (0, _):
            resultLog += "on the y-axis"
        case (-2...2, -2...2):
            resultLog += "inside the box"
        default:
            resultLog += "outside the box"
        } // inside the box
    }
    
    fileprivate func switch_bind_value(_ point: (Int, Int)) {
        switch point {
        case (let x, 0):
            resultLog += "on the x-axis with an x value of \(x)"
        case (0, let y):
            resultLog += "on the y-axist whit a y value of \(y)"
        case let (x, y):
            resultLog += "somewhere ele at (\(x), \(y))"
        } // on the x-axis with an x value of 2
    }
}

// MARK: - Use where
extension ProcessControlViewModel {
    fileprivate func where_by_switch(_ point: (Int, Int)) {
        switch point {
        case let (x, y) where x == y:
            resultLog += "on the line x == y"
        case let (x, y) where x == -y:
            resultLog += "on the lin x == -y"
        case let (x, y):
            resultLog += "(\(x), \(y)) is just some arbitrary point"
        }
    }
    
    fileprivate func where_by_for(_ numbers: [Int]) {
        var sum = 0
        for number in numbers where number > 0 {
            sum += number
        }
        
        resultLog += "将所有正数加起来 = \(sum)"
    }
}


