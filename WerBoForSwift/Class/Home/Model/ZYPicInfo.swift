//
//  ZYPicInfo.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/24.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYPicInfo: ZYBaseModel {

    var thumbnail_pic: String?
    
    override init(dict: Dictionary<String, AnyObject>) {
        super.init(dict: dict)
        setValuesForKeysWithDictionary(dict)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
