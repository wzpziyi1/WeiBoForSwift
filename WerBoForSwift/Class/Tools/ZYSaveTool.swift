//
//  ZYSaveTool.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/9.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYSaveTool: NSObject {
    
    private static let instance = ZYSaveTool()
    
    private let infoFilename = "LoginInfo"
    
    class func sharedSaveTool() -> ZYSaveTool
    {
        return instance
    }
    
    //登陆信息
    func writeLoginInfo(info: ZYLoginInfo)
    {
        
        let path = (kCachePath! as NSString).stringByAppendingPathComponent(self.infoFilename)
        
        NSKeyedArchiver.archiveRootObject(info, toFile: path)
        
    }
    
    //登陆信息
    func readLoginInfo() ->ZYLoginInfo?
    {
        let path = (kCachePath! as NSString).stringByAppendingPathComponent(self.infoFilename)
        return NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? ZYLoginInfo
        
    }
}
