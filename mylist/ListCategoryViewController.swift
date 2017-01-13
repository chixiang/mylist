//
//  ListCategoryViewController.swift
//  mylist
//
//  Created by 池翔 on 2017/1/9.
//  Copyright © 2017年 池翔. All rights reserved.
//

import UIKit

class ListCategoryViewController: UITableViewController, listCategoryDetailDelegate {
    
    var listCategories = [ListCategory]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lc1 = ListCategory(name: "Work")
        listCategories.append(lc1)
        
        let lc2 = ListCategory(name: "Study")
        listCategories.append(lc2)
        
        let lc3 = ListCategory(name: "Personal")
        listCategories.append(lc3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCategories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            cell?.accessoryType = .detailDisclosureButton
        }
        
        let lc = listCategories[indexPath.row]
        cell?.textLabel?.text = lc.name
        
        return cell!
    }

    // MARK: - 跳转
    // 通过编码实现跳转
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navigationController = storyboard!.instantiateViewController(withIdentifier: "listCategoryDetailNavigationController") as! UINavigationController
        let controller = navigationController.topViewController as! ListCategoryDetailViewController
        let listCategory = listCategories[indexPath.row]
        controller.listCategoryToEdit = listCategory
        
        controller.listCategoryDetailDelegate = self
        present(navigationController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let listCategory = listCategories[indexPath.row]
        performSegue(withIdentifier: "showLists", sender: listCategory)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLists" {
            let allListVC = segue.destination as! AllListViewController
            allListVC.listCategory = sender as! ListCategory
        } else if segue.identifier == "addListCategory" {
            let navigation = segue.destination as! UINavigationController
            let lcdetail = navigation.topViewController as! ListCategoryDetailViewController
            lcdetail.listCategoryDetailDelegate = self
        }
    }
    
    // MARK: - delegate
    func listCategoryDetailViewController(sender: ListCategoryDetailViewController, didFinishAddListCategory listCategory: ListCategory) {
        listCategories.append(listCategory)
        let indexPath = NSIndexPath(row: listCategories.count - 1, section: 0)
        tableView.insertRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        //saveAllList()

    }
    
    func listCategoryDetailViewController(sender: ListCategoryDetailViewController, didFinishEditListCategory listCategory: ListCategory) {
        let index = listCategories.index(of: listCategory)
        if let index = index {
            let indexPath = NSIndexPath(row: index, section: 0)
            let cell = tableView.cellForRow(at: indexPath as IndexPath)
            cell?.textLabel?.text = listCategory.name
        }
    }


}
