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
    private lazy var baseOperatorDatas = ["常量"]
    private lazy var infoView: AlertInfoView = {
        let infoView = AlertInfoView.loadViewFromNib()
        infoView.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 200))
        infoView.isHidden = true
        infoView.backgroundColor = UIColor(rgb: 250)
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
        
        infoView.isHidden = false
        let text = baseOperatorDatas[indexPath.row];
        if text == baseOperatorDatas[0] {
            use_constant()
        }
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
    fileprivate func use_constant() {
        /// 只能赋值一次
        let age1 = 10;
        
        /// 先定义，后赋值
        let age2: Int
        age2 = 20
        
        /// 函数返回值
        let age3 = getAge()
        infoView.titleLabel.text = "我是常量"
        infoView.textView.text = "age1 = \(age1)\nage2 = \(age2)\nage3 = \(age3)\n"
    }
    
    fileprivate func getAge() -> Int {
        return 30
    }
    
    
}
