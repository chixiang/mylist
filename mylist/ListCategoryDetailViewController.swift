//
//  ListCategoryDetailViewController.swift
//  mylist
//
//  Created by 池翔 on 2017/1/10.
//  Copyright © 2017年 池翔. All rights reserved.
//

import UIKit

protocol listCategoryDetailDelegate: class {
    func listCategoryDetailViewController(sender: ListCategoryDetailViewController, didFinishAddListCategory listCategory: ListCategory)
    func listCategoryDetailViewController(sender: ListCategoryDetailViewController, didFinishEditListCategory listCategory: ListCategory)
}

class ListCategoryDetailViewController: UITableViewController {

    @IBOutlet weak var textField: UITextField!
    weak var listCategoryDetailDelegate: listCategoryDetailDelegate?
    var listCategoryToEdit: ListCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let lc = listCategoryToEdit {
            navigationItem.title = "编辑分类"
            textField.text = lc.name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func save(_ sender: AnyObject) {
        if let lc = listCategoryToEdit {
            lc.name = textField.text!
            listCategoryDetailDelegate?.listCategoryDetailViewController(sender: self, didFinishEditListCategory: lc)
        } else {
            let lc = ListCategory(name: textField.text!)
            listCategoryDetailDelegate?.listCategoryDetailViewController(sender: self, didFinishAddListCategory: lc)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
