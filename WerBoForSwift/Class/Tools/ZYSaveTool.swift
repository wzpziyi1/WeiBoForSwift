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
    
    //存储登陆信息
    func writeLoginInfo(info: ZYLoginInfo)
    {
        
        let path = self.infoFilename.cachePath()
        
        NSKeyedArchiver.archiveRootObject(info, toFile: path)
        
    }
    //取出登陆信息
    func readLoginInfo() ->ZYLoginInfo?
    {
        let path = self.infoFilename.cachePath()
        return NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? ZYLoginInfo
        
    }
    
    //存储app版本信息
    func writeAppVersion(version: String)
    {
        let versionKey = "CFBundleVersion"
        let userDefault = NSUserDefaults()
        userDefault.setObject(version, forKey: versionKey)
        userDefault.synchronize()
    }
    
    //读取app版本信息
    func readAppVersion() ->String?
    {
        let versionKey = "CFBundleVersion"
        let userDefault = NSUserDefaults()
        return (userDefault.objectForKey(versionKey) as? String)
    }
}
