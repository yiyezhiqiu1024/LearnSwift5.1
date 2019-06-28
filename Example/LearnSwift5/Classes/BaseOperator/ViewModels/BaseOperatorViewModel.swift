//
//  BaseOperatorViewModel.swift
//  LearnSwift5
//
//  Created by CoderSLZeng on 2019/6/28.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

import UIKit

class BaseOperatorViewModel: NSObject, ViewModelProtocol {

    // MARK: - properties
    private lazy var baseOperatorDatas = ["常量的使用-use_constant",
                                          "变量的使用-use_variable",
                                          "标识符的使用-use_🐂🍺"]
    
    private lazy var infoView: AlertInfoView = {
        let infoView = AlertInfoView.loadViewFromNib()
        infoView.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 200))
        infoView.isHidden = true
        infoView.backgroundColor = UIColor(rgb: 250)
        infoView.textView.backgroundColor = .black
        infoView.textView.textColor = .green
        infoView.closeBtn.addTarget(self, action: #selector(closeButtonDidTouch), for: .touchUpInside)
        return infoView
    }()
    
    func bindViewModel(_ bindView: UIView) {
        let tableView = bindView as! UITableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.addSubview(infoView)
        infoView.center = tableView.center
    }
    
}

// MARK: - Table view data source
extension BaseOperatorViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baseOperatorDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "HomeCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        cell?.textLabel?.text = baseOperatorDatas[indexPath.row]
        return cell!
    }
}

// MARK: - Table view delegate
extension BaseOperatorViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let text = baseOperatorDatas[indexPath.row]
        let datas = text.split(separator: "-")
        guard let title = datas.first else { return }
        infoView.titleLabel.text = String(title)
        infoView.isHidden = false
        guard let selectorName = datas.last else { return }
        let aSelector = NSSelectorFromString(String(selectorName))
        perform(aSelector)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

// MARK: - Action
extension BaseOperatorViewModel {
    @objc func closeButtonDidTouch() {
        infoView.isHidden = true
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
        
        infoView.textView.text = "age1 = \(age1)\n" + "age2 = \(age2)\n" + "age3 = \(age3)\n"
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
        infoView.textView.text = previousText + afterText
    }
    
    /// 标识符的使用
    /// 标识符（比如常量名、变量名、函数名）几乎可以使用任何字符
    /// 标识符不能以数字开头，不能包含空白字符、制表符、箭头等特殊字符
    @objc fileprivate func use_🐂🍺() {
        let 👽 = "ET"
        let milk = "🥛"
        let text = 👽 + " like " + milk
        myLog(text)
        infoView.textView.text = text
    }
    
}
