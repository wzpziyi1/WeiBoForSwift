//
//  ZYUserInfo.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/24.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYUserInfo: ZYBaseModel {
    
    var id: NSNumber?
    var screen_name: String?                        //昵称
    var avatar_large: String?                       //大图url
    var profile_image_url: String?                  //头像url
    
    var verified: NSNumber?                         //是否是微博认证用户，即加V用户，true：是，false：否
    
    override init(dict: Dictionary<String, AnyObject>) {
        super.init(dict: dict)
        setValuesForKeysWithDictionary(dict)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        id = aDecoder.decodeObjectForKey("id") as? NSNumber
        screen_name = aDecoder.decodeObjectForKey("screen_name") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        profile_image_url = aDecoder.decodeObjectForKey("profile_image_url") as? String
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(id, forKey: "id")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        aCoder.encodeObject(profile_image_url, forKey: "profile_image_url")
    }
}
