//
//  FunctionViewModel.swift
//  LearnSwift5
//
//  Created by CoderSLZeng on 2019/7/1.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

import UIKit



import UIKit

class FunctionViewModel: NSObject, ViewModelProtocol {
    // MARK: - Properties
    private var titleLabel : UILabel?
    private var logTV: UITextView?
    private let defalutLog = "尝试点击下方选项条，查看结果吧"
    private var resultLog = ""
    
    private let titles = ["函数的定义",
                          "返回元组：实现多返回",
                          "参数标签",
                          "默认参数值",
                          "可变参数",
                          "Swift自带的print函数",
                          "输入输出函数",
                          "重载函数",
                          "内联函数",
                          "函数类型",
                          "函数类型作为函数参数",
                          "高阶函数",
                          "别名",
                          "嵌套函数"]
    
    private let funNames = ["use_definition",
                            "use_return_Tuple",
                            "use_argument_label",
                            "use_defalut_parameter_value",
                            "use_variadic_parameter",
                            "use_Swift_print",
                            "use_inout_parameter",
                            "use_function_overload",
                            "use_inline_function",
                            "use_function_type",
                            "use_function_parameter_by_function_type",
                            "use_higher_order_function",
                            "use_typealias",
                            "use_nested_function"]
    
    
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
extension FunctionViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "FunctionCell"
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
extension FunctionViewModel: UITableViewDelegate {
    
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

// MARK: - 函数的使用
extension FunctionViewModel {
    /// 使用：函数的定义
    @objc fileprivate func use_definition() {
        
        let result = add(v1: 10, v2: 20)
        resultLog += "10 + 20 = \(result)"
        
        resultLog += newLine
        resultLog = "pi = \(pi())"
        
        resultLog += newLine
        sayHello()
        
        resultLog += newLine
        sayGood()
        
        resultLog += newLine
        sayThanks()
        
        logTV?.text = resultLog
    }
    
    
    /// 使用：返回元组：实现多返回值
    @objc fileprivate func use_return_Tuple() {
        
        let result = calculate(v1: 20, v2: 10)

        resultLog = "sum = \(result.sum)" + newLine
        resultLog += "difference = \(result.difference)" + newLine
        resultLog += "average = \(result.average)" + newLine
        
        logTV?.text = resultLog
    }
    
    /// 使用：参数标签
    @objc fileprivate func use_argument_label() {
        resultLog = goToWork(at: "08:00")
        resultLog += newLine
        let result = add(10, 20)
        resultLog += "10 + 20 = \(result)"
        logTV?.text = resultLog
    }
    
    /// 使用：默认参数值
    @objc fileprivate func use_defalut_parameter_value() {
        let result1 = check(name: "Jack", age: 20, job: "Doctor") // name = jack, age = 20, job = Doctor
        let result2 = check(name: "Rose", age: 18) // name = Rose, age = 18, job = none
        let result3 = check(age: 10, job: "Batman") // name = nobody, age = 10, job = Batman
        let result4 = check(age: 15) // name = nobody, age = 15, job = none
        let result5 = testDefaultParameterValueArgumentLabel(middle: 20)
        resultLog = result1 + newLine + result2 + newLine + result3 + newLine + result4 + newLine + result5
        logTV?.text = resultLog
    }
    
    /// 使用：可变参数
    @objc fileprivate func use_variadic_parameter() {
        resultLog = "\(total(10, 20, 30, 40))" // 100
        resultLog += newLine
        resultLog = testVariadicParameterValueArgumentLabel(10, 20, 30, string: "Jack", "Rose")
        
        logTV?.text = resultLog
    }
    
    /// Swift自带的print函数
    @objc fileprivate func use_Swift_print() {
        print(1, 2, 3, 4, 5) // 1 2 3 4 5
        print(1, 2, 3, 4, 5, separator: "_") // 1_2_3_4_5
        print("My name is Jake", terminator: "")
        print("My age is 18")
        
        logTV?.text = "阅读源码了解Swift自带的print函数的使用"
    }
    
    /// 使用：输入输出函数
    @objc fileprivate func use_inout_parameter() {
        var num1 = 10
        var num2 = 20
        
        resultLog = "交换之前：num1 = \(num1), num2 = \(num2)"
        
        swapValues(&num1, &num2)
        
        resultLog += newLine
        resultLog += "交换之后：num1 = \(num1), num2 = \(num2)"
        logTV?.text = resultLog
    }
    
    /// 使用：重载函数
    @objc fileprivate func use_function_overload() {
        let result1 = sum(v1: 10, v2: 20) // 30
        let result2 = sum(v1: 10, v2: 20, v3: 30) // 60
        let result3 = sum(v1: 10, v2: 20.0) // 30.0
        let result4 = sum(v1: 10.0, v2: 20) // 30.0
        let result5 = sum(10, 20) // 30
        let result6 = sum(a: 10, b: 20) // 30
        
        resultLog = "reslut1 = \(result1)" + newLine
        
        resultLog += newLine + "参数个数不同" + newLine
        resultLog += "reslut2 = \(result2)" + newLine
        
        resultLog += newLine + "参数类型不同" + newLine
        resultLog += "reslut3 = \(result3)" + newLine
        resultLog += "reslut4 = \(result4)" + newLine
        
        resultLog += newLine + "参数标签不同" + newLine
        resultLog += "reslut5 = \(result5)" + newLine
        resultLog += "reslut6 = \(result6)"

        logTV?.text = resultLog
    }
    
    /// 使用：内联函数
    @objc fileprivate func use_inline_function() {
        resultLog = neverInline()
        resultLog += newLine
        resultLog += alwaysInline()
        logTV?.text = resultLog
    }
    
    /// 使用：函数类型
    @objc fileprivate func use_function_type() {
        functionType()
        let result = functionType_sum(a: 10, b: 20)
        resultLog = "\(result)"
        logTV?.text = resultLog
    }
    
    /// 使用：高阶函数
    @objc fileprivate func use_higher_order_function() {
        let result1 = forward(true)(3) // 4
        let result2 = forward(false)(3) // 2
        
        resultLog = "result1 = \(result1)" + newLine + "result2 = \(result2)"
        logTV?.text = resultLog
    }
    
    /// 使用：函数类型作为函数参数 
    @objc fileprivate func use_function_parameter_by_function_type() {
        resultLog = printResult(append, 5, 2)
        resultLog += newLine
        resultLog += printResult(difference, 5, 2)
        logTV?.text = resultLog
    }
    
    /// 使用：别名
    @objc fileprivate func use_typealias() {
        
        test((2011, 9, 10))
        logTV?.text = "阅读源码了解别名的使用"
    }
    
    /// 使用：嵌套函数
    @objc fileprivate func use_nested_function() {
        use_higher_order_function()
    }
}

// MARK: - 函数的定义
extension FunctionViewModel {
    // 有返回值
    
    
    /// 求和【概述】
    ///
    /// 将2个整数相加【更详细的描述】
    ///
    /// - Parameters:
    ///   - v1: 第1个整数
    ///   - v2: 第2个整数
    /// - Returns: 2个整数的和
    /// - Note: 传入2个整数即可【批注】
    ///
    fileprivate func add(v1: Int, v2: Int) -> Int {
        return v1 + v2
        // 如果整个函数体是一个单一表达式，那么函数会隐式返回(Implicit Return)这个表达式
        //        v1 + v2 // 可以不用写return
    }
    
    
    fileprivate func pi() -> Double {
        return 3.14
    }
    
    // 无返回值
    fileprivate func sayHello() -> Void {
        resultLog += "Hello"
    }
    
    fileprivate func sayGood() -> () {
         resultLog += "good"
    }
    
    fileprivate func sayThanks() {
         resultLog += "Thanks"
    }
    
}

// MARK: - 返回元组：实现多返回值
extension FunctionViewModel {
    fileprivate func calculate(v1: Int, v2: Int) -> (sum: Int, difference: Int, average: Int) {
        let sum = v1 + v2
        let defference = v1 - v2
        let average = sum >> 1
        return (sum, defference, average)
    }
}

// MARK: - 参数标签
extension FunctionViewModel {
    // 可以修改参数标签
    fileprivate func goToWork(at time: String) -> String {
        return "this time is \(time)"
    }
    
    // 可以使用下划线 _ 省略参数标签
    fileprivate func add(_ v1: Int, _ v2: Int) -> Int {
       return v1 - v2
    }
}

// MARK: - 默认参数值
extension FunctionViewModel {
    // 参数可以有默认值
    fileprivate func check(name: String = "nobody", age: Int, job: String = "none") -> String {
        return "name = \(name), age = \(age), job = \(job)"
    }
    
    // C++的默认参数值有个限制：必须从右往左设置。由于Swift拥有参数标签，因此并没有限制
    // 但是在省略参数标签时，需要特别注意，避免出错
    // 这里的middle不可以省略参数标签
    fileprivate func testDefaultParameterValueArgumentLabel(_ first: Int = 10, middle: Int, _ last: Int = 30) -> String {
        return "first = \(first), middle = \(middle), last = \(last)"
    }
    
}

// MARK: - 可变参数
extension FunctionViewModel {
    fileprivate func total(_ numbers: Int...) -> Int {
        var total = 0
        for number in numbers {
            total += number
        }
        return total
    }
    
    // 一个函数最多只能有1个可变参数
    // 紧跟在可变参数后面的参数不能省略参数标签
    fileprivate func testVariadicParameterValueArgumentLabel(_ numbers: Int..., string: String, _ other: String) -> String {
        var result = ""
        for number in numbers {
            result += "\(number), "
        }
        
        result += "string = \(string), "
        result += "other = \(other)"
        return result
    }
}

// MARK: - 输入输出参数
extension FunctionViewModel {
    /**
     可以用 inout 定义一个输入输出参数：可以在函数内部修改外部实参的值
     可变参数不能标记为 inout
     inout 参数不能有默认值
     inout 参数只能出入可以被多次赋值的
     这里所示代码中 inout 参数的本质是地址传递（引用传递）
     如果传递给 inout 参数的是计算属性、有监听的属性等内容
     其本质并非引用传递，在【属性】章节再作详细讲解
    */
    fileprivate func swapValues(_ v1: inout Int, _ v2: inout Int) {
//        let tmp = v1
//        v1 = v2
//        v2 = tmp
        (v1, v2) = (v2, v1)
    }
}

// MARK: - 函数重载
extension FunctionViewModel {
    /**
     规则
     函数名相同
     参数个数不同 || 参数类型不同 || 参数标签不同
     
     注意点：
        1.返回值类型与函数重载无关
            func sum(v1: Int, v2: Int) -> Int { v1 + v2 }
            func sum(v1: Int， v2: Int) { }
            sum(v1: 10, v2: 20) // error: Ambiguous use of 'sum(v1:v2)'
     
        2.默认参数值和函数重载一起使用产生二义性时，编译器并不会报错（在C++中会报错）
            func sum(v1: Int, v2: Int) -> Int { v1 + v2 }
            func sum(v1: Int, v2: Int, v3: Int = 10) -> Int { v1 + v2 + v3 }
            sum(v1: 10, v2: 20) // 会调用sum(v1: Int, v2: Int)
     
        3.可变参数、省略参数标签、函数重载一起使用产生二义性时，编译器有可能会报错
            func sum(v1: Int, v2: Int) -> Int { v1 + v2 }
            func sum(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
            func sum(_ numbers: Int...) -> Int {
                var total = 0
                for number in numbers {
                    total += number
                }
                return total
            }
            sum(10, 20) // error: Ambiguous use of 'sum'
    */
    func sum(v1: Int, v2: Int) -> Int {
        return v1 + v2
    }
    
    func sum(v1: Int, v2: Int, v3: Int) -> Int {
        return v1 + v2 + v3
    } // 参数个数不同
    
    func sum(v1: Int, v2: Double) -> Double {
        return Double(v1) + v2
    } // 参数类型不同
    
    func sum(v1: Double, v2: Int) -> Double {
        return v1 + Double(v2)
    } // 参数类型不同
    
    func sum(_ v1: Int, _ v2: Int) -> Int {
        return v1 + v2
    } // 参数标签不同
    
    func sum(a: Int, b: Int) -> Int {
        return a + b
    } // 参数标签不同
}

// MARK: - 内联函数
extension FunctionViewModel {
    /**
     @inline
     如果开启了编译器优化（Release模式默认会开启优化），编译器会自动将某些函数变成内联函数
     将函数调用展开成函数体
     在Release模式下，编译器已经开启优化，会自动决定哪些函数需要内联，因此没必要使用@inline
     在Debug模式下，需要手动设置开始优化
        Build Settings -> 🔍 optimization -> Swift Compile - Code Generation -> Optimization Level -> Debug 修改为 Optimize for Speed[-O]
     
     哪些函数不会被自动内联
        1.函数体比较长
        2.包含递归调用
        3.包含动态派发
        4....
    */
    
    // 永远不会被内联（即使开启了编译器优化）
    @inline(never) fileprivate func neverInline() -> String {
        return "使用@inline(never)，永远不会被内联（即使开启了编译器优化）"
    }
    
    // 开启了编译器优化后，即使代码很长，也会被内联（递归调用函数、动态派发的函数除外）
    @inline(__always) fileprivate func alwaysInline() -> String {
        return "使用@inline(__always)，开启了编译器优化后，即使代码很长，也会被内联（递归调用函数、动态派发的函数除外）"
    }
}

// MARK: - 函数类型
extension FunctionViewModel {
    /**
     每个函数都有类型的，函数类型由 形式参数类型、返回值类型组成
    */
    fileprivate func functionType() { } // () -> Void 或者 () -> ()
    
    fileprivate func functionType_sum(a: Int, b: Int) -> Int {
        return a + b
    } // （Int, Int) -> Int
    
    /**
     // 定义变量
     var fn: (Int, Int) -> Int = functionType_sum
     fn(2, 3) // 5, 调用是不需要参数标签
    */
}

// MARK: - 函数类型作为函数参数
extension FunctionViewModel {
    fileprivate func append(v1: Int, v2: Int) -> Int {
        return v1 + v2
    }
    
    fileprivate func difference(v1: Int, v2: Int) -> Int {
        return v1 - v2
    }
    
    fileprivate func printResult(_ mathFn: (Int, Int) -> Int, _ a: Int, _ b: Int) -> String {
        return "Result: \(mathFn(a, b))"
    }
}

// MARK: - 嵌套函数 & 高阶函数
extension FunctionViewModel {
    /**
     嵌套函数
        将函数定义在函数内部
 
     高阶函数（Higher-Order Function）
        返回值是函数类型的函数
    */
    fileprivate func forward(_ forward: Bool) -> (Int) -> Int {
        
        
        func next(_ input: Int) -> Int {
            return input + 1
        }
        
        func previous(_ input: Int) -> Int {
            return input - 1
        }
        
        return forward ? next : previous
    }

}

// MARK: - 别名
extension FunctionViewModel {
    typealias Byte = Int8
    typealias Short = Int16
    typealias Long = Int64
    
    typealias Date = (year: Int, month: Int, day: Int)
    func test(_ date: Date) {
        myLog(date.0)
        myLog(date.year)
    }
    
    /**
    typealias IntFn = (Int, Int) -> Int
    func difference(v1: Int, v2: Int) -> Int {
        return v1 - v2
    }
    let fn: IntFn = difference
    fn(20, 10) // 10
    
    func setFn(_ fn: IntFn) { }
    setFn(difference)
    
    func getFn() -> IntFn { difference }
    */
}

