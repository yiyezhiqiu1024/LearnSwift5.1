//
//  HomeTVC.swift
//  LearnSwift5
//
//  Created by CoderSLZeng on 2019/6/28.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

import UIKit

class HomeTVC: UITableViewController {
    
    // MARK: - properties
    lazy var rows = ["基本操作-BaseOperatorVC"]
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "LearnSwift5.1"
    }
}

// MARK: - Table view data source
extension HomeTVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "HomeCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        cell?.textLabel?.text = rows[indexPath.row]
        return cell!
    }
}

// MARK: - Table view delegate
extension HomeTVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let text = rows[indexPath.row]
        guard let namespace = Bundle.main.namespace else { return }
        let datas = text.split(separator: "-")
        guard let title = datas.first else { return }
        guard let VCName = datas.last else { return }
        guard let aClass = NSClassFromString(namespace + "." + String(VCName)) as? UIViewController.Type else { return }
        let vc = aClass.init()
        vc.navigationItem.title = String(title)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}


