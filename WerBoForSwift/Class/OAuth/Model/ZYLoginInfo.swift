//
//  ZYLoginInfo.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/6.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYLoginInfo: ZYBaseModel {
    var access_token: String?
    var expires_in: NSNumber?
    
    var uid: String?
    
    //access_token是否过期
    var expireDate: NSDate?
    
    override init(dict: Dictionary<String, AnyObject>)
    {
        super.init(dict: dict)
        self.setValuesForKeysWithDictionary(dict)
        
        if (expireDate == nil)
        {
            expireDate = NSDate().dateByAddingTimeInterval((expires_in?.doubleValue)!)
        }
    }
    
    func display()
    {
        print("access_token= \(access_token)\n expires_in= \(expires_in)\n uid= \(uid)\n expireDate= \(expireDate)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expireDate = aDecoder.decodeObjectForKey("expireDate") as? NSDate
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expireDate, forKey: "expireDate")
    }
}

