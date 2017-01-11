//
//  List.swift
//  mylist
//
//  Created by 池翔 on 2017/1/7.
//  Copyright © 2017年 池翔. All rights reserved.
//

import UIKit

class List: NSObject, NSCoding {
    
    var name: String = "No Name"
    var isChecked: Bool = false

    let nameIdentifier = "name"
    let isCheckedString = "isChecked"
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: nameIdentifier)
        aCoder.encode(isChecked, forKey: isCheckedString)
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: nameIdentifier) as! String
        isChecked = aDecoder.decodeBool(forKey: isCheckedString)
        super.init()
    }
}
