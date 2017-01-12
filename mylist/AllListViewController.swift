//
//  ViewController.swift
//  mylist
//
//  Created by 池翔 on 2017/1/5.
//  Copyright © 2017年 池翔. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController, listDetailDelegate {
    
    var lists = [List]()
    var listCategory: ListCategory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAllList()
        self.navigationItem.title = listCategory.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ListDetailDelegate
    func listDetailViewController(controller: ListDetailViewController, didFinishAddList list: List) {
        lists.append(list)
        let indexPath = NSIndexPath(row: lists.count - 1, section: 0)
        tableView.insertRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        saveAllList()
    }
    
    func listDetailViewController(controller: ListDetailViewController, didFinishEditList list: List) {
        let index = lists.index(of: list)
        if let index = index {
            let indexPath = NSIndexPath(row: index, section: 0)
            let cell = tableView.cellForRow(at: indexPath as IndexPath) as! ListCell
            configureCell(cell: cell, list: list)

        }
        saveAllList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationVC = segue.destination as! UINavigationController
        let addListVC = navigationVC.topViewController as! ListDetailViewController
        addListVC.addListDelegate = self
        
        if segue.identifier == "addList" {
            // TODO
        } else if segue.identifier == "editList" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            
            if let indexPath = indexPath {
                let list = lists[indexPath.row]
                addListVC.listToEdit = list
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListCell
        let list = lists[indexPath.row]
        
        configureCell(cell: cell, list: list)
        
        return cell
    }
    
    func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let filePath = paths[0] as NSString
        return filePath.appendingPathComponent("AllList.plist")
    }
    
    func saveAllList() {
        // 1. 创建 data 对象
        let data = NSMutableData()
        
        // 2. 把数据写入到 data 对象
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(lists, forKey: "AllList")
        archiver.finishEncoding()
        
        // 3. 把 data 对象写入到文件
        data.write(toFile: dataFilePath(), atomically: true)
        
    }
    
    func loadAllList() {
        // 1. 创建 data 对象
        let data = NSData(contentsOfFile: dataFilePath())
        if let data = data {
            // 2. 从 data 中转换成内存对象 [List]
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
            lists = unarchiver.decodeObject(forKey: "AllList") as! [List]
            unarchiver.finishDecoding()
        }
    }

    // MARK: - 事件
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let list = lists[indexPath.row]
        
        let optionalCell = tableView.cellForRow(at: indexPath)
        if let cell = optionalCell {
            let checkMarkLabel = cell.viewWithTag(1001) as! UILabel
            if checkMarkLabel.text == "√" {
                checkMarkLabel.text = ""
                list.isChecked = false
            } else {
                checkMarkLabel.text = "√"
                list.isChecked = true
            }
        }
        saveAllList()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        lists.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        saveAllList()
    }
    
    func configureCell(cell: ListCell, list: List) {
        cell.customLabel.text = list.name
        
        let checkMarkLabel = cell.viewWithTag(1001) as! UILabel
        print(list.isChecked)
        if list.isChecked {
            //cell.accessoryType = .checkmark
            checkMarkLabel.text = "√"
        } else {
            //cell.accessoryType = .none
            checkMarkLabel.text = ""
        }
        
    }
}

