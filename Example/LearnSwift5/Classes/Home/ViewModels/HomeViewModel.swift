//
//  HomeViewModel.swift
//  LearnSwift5
//
//  Created by Anthony on 2019/6/29.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject, ViewModelProtocol {
    
    // MARK: - Properties
    private let titles = ["基础语法",
                          "流程控制",
                          "函数"]
    
    private let VCNames = ["BasicGrammarVC",
                           "ProcessControlVC",
                           "FunctionVC"]
    
    // MARK: - Interface
    func bindView(_ bindView: UIView) {
        
        if bindView.isMember(of: UITableView.self) {
            let tableView = bindView as! UITableView
            tableView.dataSource = self
            tableView.delegate = self
            tableView.bounces = false
        }
    }
}

// MARK: - Table view data source
extension HomeViewModel: UITableViewDataSource {
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
        cell?.detailTextLabel?.text = VCNames[indexPath.row]
        return cell!
    }
}

// MARK: - Table view delegate
extension HomeViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let namespace = Bundle.main.namespace else { return }
        let VCName = VCNames[indexPath.row]
        guard let aClass = NSClassFromString(namespace + "." + String(VCName)) as? UIViewController.Type else { return }
        let VC = aClass.init()
        VC.title = titles[indexPath.row];
        tableView.currentViewController.navigationController?.pushViewController(VC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}



