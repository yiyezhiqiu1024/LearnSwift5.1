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
                          "浮点类型的使用",
                          "字面量的使用",
                          "类型转换的使用",
                          "元组的使用"]
    
    private let funNames = ["use_constant",
                            "use_variable",
                            "use_🐂🍺",
                            "use_IntTypes",
                            "use_FloatAndDoubleTypes",
                            "use_literal",
                            "use_convertTypes",
                            "use_Tuple"]
    
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
        // 只能赋值一次
        // 直接赋值
        let age1 = 10
        
        // 先定义，后赋值
        let age2: Int
        age2 = 20
        
        // 函数返回值
        let age3 = getAge()
        
        logTV?.text = "age1 = \(age1)\n" + "age2 = \(age2)\n" + "age3 = \(age3)\n"
    }
    
    fileprivate func getAge() -> Int {
        return 30
    }
    
    /// 变量的使用
     @objc fileprivate func use_variable() {
        
        // 直接赋值
        var age1 = 10
        
        // 先定义，后赋值
        var age2: Int
        age2 = 20
        
        // 函数返回值
        var age3 = getAge()
        
        let previousText = "原始的值：\n" + "age1 = \(age1)\n" + "age2 = \(age2)\n" + "age3 = \(age3)\n"
        
        // 修改原始的值
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
        logTV?.text = text
    }
    
    // MARK: - 常见数据类型
    /// 整数类型的使用
    @objc fileprivate func use_IntTypes() {
        var log = ""
        // 有符号
        let int8: Int8 = -8
        let int16: Int16 = -16
        let int32: Int32 = -32
        let int64: Int64 = -64
        log += "Int8 = \(int8)\nInt16 = \(int16)\nInt32 = \(int32)\nInt64 = \(int64)"
        
        // 无符号
        let uint8: UInt8 = 8
        let uint16: UInt16 = 16
        let uint32: UInt32 = 32
        let uint64: UInt64 = 64
        log += "\n\nUInt8 = \(uint8)\nUInt16 = \(uint16)\nUInt32 = \(uint32)\nUInt64 = \(uint64)"
        
        // 在32bit平台，Int等价于Int32, Int等价于Int64
        // 整数的最值
        let maxUInt8 = UInt8.max
        let minInt16 = Int16.min
        log += "\n\nUInt8的最大值 = \(maxUInt8)\nInt16的最小值 = \(minInt16)"
        
        // 一般情况下，都是直接使用Int即可
        let int = 10
        logTV?.text = log + "\n\n一般情况下，都是直接使用Int即可\n Int = \(int)"
    }
    
    /// 浮点类型的使用
    @objc fileprivate func use_FloatAndDoubleTypes() {
        // Float: 32位，精度只有6位
        let float: Float = 10.0
        
        // Double: 64位，精度至少15位
        let double: Double = 10.0
        
        logTV?.text = "Float: 32位，精度只有6位\nFloat = \(float)\n\nDouble: 64位，精度至少15位\nDouble = \(double)"
    }
    
    /// 字面量的使用
    @objc fileprivate func use_literal() {
        
        // 布尔
        var log = "布尔\n"
        let bool = true // 取反是false
        log += "Bool = \(bool)\n"
        
        // 字符串
        log += "\n字符串\n"
        let string = "SLZeng"
        log += "String = " + string + "\n"
        
        // 字符（可存储ASSCII字符、Unicode字符）
        log += "\n字符（可存储ASSCII字符、Unicode字符）\n"
        let character: Character = "🐶"
        log += "Character = \(character)\n"
        
        // 整数
        log += "\n整数\n"
        let intBinary = 0b10001 // 二进制
        log += "二进制 0b10001 = \(intBinary)\n"
        
        let intOctal = 0o21 // 八进制
        log += "八进制 0o21 = \(intOctal)\n"
        
        let intDecimal = 17 // 十进制
        log += "十进制 17 = \(intDecimal)\n"
        
        let intHexadecimal = 0x11 // 十六进制
        log += "十六进制 0x11 = \(intHexadecimal)\n"
        
        // 浮点数
        log += "\n浮点数\n"
        
        let doubleDecimal1 = 125.0 // 十进制，
        log += "十进制 125.0 = \(doubleDecimal1)\n"
        log += "125等价于1.25e2， 0.0125等价于1.25e-2\n"
        
        let doubleDecimal2 = 12.1875 // 十进制
        log += "十进制 12.1875 = \(doubleDecimal2)\n"
        
        let doubleDecimal3 = 1.21875e1 // 十进制
        log += "十进制 1.21875e1 = \(doubleDecimal3)\n"
        
        let doubleHexadecimal1 = 0xFp2 // 十六进制
        log += "十六进制 0xFp2 = \(doubleHexadecimal1)\n"
        log += "意味着15×2^2，相当于十进制的60.0\n"
        
        let doubleHexadecimal2 = 0xFp-2 // 十六进制
        log += "十六进制 0xFp-2 = \(doubleHexadecimal2)\n"
        log += "意味着15×2-2，相当于十进制的3.75\n"
        
        let doubleHexadecimal3 = 0xC.3P0 // 十六进制
        log += "十六进制 0xC.3P0 = \(doubleHexadecimal3)\n"
        
        log += "\n整数和浮点数可以添加额外的零或者下划线来增强可读性\n"
        log += "例如：100_0000、1_000_000.000_000_1、000123.456\n"
        
        // 数组
        log += "\n数组\n"
        let array = [1, 3, 5, 7, 9]
        log += "array = \(array)\n"
        
        // 字典
        log += "\n字典\n"
        let dictionary: [String : Any] = ["name" : "SLZeng",
                                          "age" : 18,
                                          "heigth" : 178,
                                          "weight" : 120]
        log += "dictionary = \(dictionary)"
        
        logTV?.text = log
    }
    
    /// 类型装换的使用
    @objc fileprivate func use_convertTypes() {
        // 整数转换
        var log = "整数转换\n"
        
        let int1: UInt16 = 2_000
        log += "int1: UInt16 = \(int1)\n"
        
        let int2: UInt8 = 1
        log += "int2: UInt8 = \(int2)\n"
        
        let int3 = int1 + UInt16(int2)
        log += "int1 + UInt16(int2) = \(int3)\n"
        
        // 整数、浮点数转换的使用
        log += "\n整数、浮点数转换\n"
        
        let int = 3
        log += "int = 3\n"
        
        let double = 0.14159
        log += "double = 0.14159\n"
        
        let doublePi = Double(int) + double
        log += "Double(int) + double = \(doublePi)\n"
        
        let intPi = Int(doublePi)
        log += "Int(doublePi) = \(intPi)\n"
        
        
        // 字面量可以直接相加，因为数字字面量本身没有明确类型
        let result = 3 + 0.14159
        
        log += "\n字面量可以直接相加，因为数字字面量本身没有明确类型\n"
        log += "3 + 0.14159 = \(result)"
        
        logTV?.text = log
    }
    
    /// 元组的使用
    @objc fileprivate func use_Tuple() {
        // 方式1
        var log = "方式1\n"
        
        let http404Error = (404, "Not Found")
        log += "let http404Error = (404, \"Not Found\")\n"
        log += "The status code is \(http404Error.0)\n"
        
        // 方式2
        log += "\n方式1\n"
        
        let (statusCode, statusMessage) = http404Error
        log += "let (statusCode, statusMessage) = http404Error\n"
        log += "The status code is \(statusCode)\n"
        log += "The status message is \(statusMessage)\n"
        
        // 方式3
        log += "\n方式3\n"
        
        let (justTheStatusCode, _) = http404Error
        log += "let (justTheStatusCode, _) = http404Error\n"
        log += "The status code is \(justTheStatusCode)\n"
        
        // 方式4
        log += "\n方式4\n"
        
        let http200Status = (statusCode: 200, description: "OK")
        log += "let http200Status = (statusCode: 200, description: \"OK\")\n"
        log += "The status code is \(http200Status.statusCode)"
        
        logTV?.text = log
    }
}
