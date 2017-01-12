//
//  ListDetailViewController.swift
//  mylist
//
//  Created by 池翔 on 2017/1/8.
//  Copyright © 2017年 池翔. All rights reserved.
//

import UIKit

protocol listDetailDelegate: class {
    func listDetailViewController(controller: ListDetailViewController, didFinishAddList list: List)
    func listDetailViewController(controller: ListDetailViewController, didFinishEditList list: List)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    weak var addListDelegate: listDetailDelegate?
    var listToEdit: List?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        
        if let listToEdit = listToEdit {
            self.textField.text = listToEdit.name
            self.navigationItem.title = "编辑清单"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        textField.becomeFirstResponder()
    }

    @IBAction func save(_ sender: AnyObject) {
        if let addListDelegate = addListDelegate {
            if let listToEdit = listToEdit {
                listToEdit.name = textField.text!
                addListDelegate.listDetailViewController(controller: self, didFinishEditList: listToEdit)
            } else {
                let list = List()
                list.name = textField.text!
                addListDelegate.listDetailViewController(controller: self, didFinishAddList: list)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText:NSString = textField.text! as NSString
        let newText:NSString = oldText.replacingCharacters(in: range, with: string) as NSString
        
        if newText.length > 0 {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
        
        return true
    }
    
}

