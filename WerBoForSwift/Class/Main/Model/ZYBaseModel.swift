//
//  ZYBaseModel.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/9.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYBaseModel: NSObject, NSCoding {
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>)
    {
        super.init()
        self.setValuesForKeysWithDictionary(dict)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
    }
    
    
    override func valueForUndefinedKey(key: String) -> AnyObject? {
        print("未解析字段： \(key)")
        return nil
    }
    
    //截取无用的key，避免崩溃
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
//        print(key)
    }
}
