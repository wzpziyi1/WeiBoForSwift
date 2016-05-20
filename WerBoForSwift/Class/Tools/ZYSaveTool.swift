//
//  ZYSaveTool.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/9.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYSaveTool: NSObject{
    
    private static let instance = ZYSaveTool()
    
    
    class func sharedSaveTool() -> ZYSaveTool
    {
        return instance
    }
    
    //存储登陆信息
    func writeLoginInfo(info: ZYLoginInfo)
    {
        
        let path = "LoginInfo.plist".cachePath()
        NSKeyedArchiver.archiveRootObject(info, toFile: path)
        
    }
    //取出登陆信息
    func readLoginInfo() ->ZYLoginInfo?
    {
        let path = "LoginInfo.plist".cachePath()
        return NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? ZYLoginInfo
        
    }
    
    //判断是否可以在登陆状态
    
    func isLogin() ->Bool
    {
        let loginInfo: ZYLoginInfo? = readLoginInfo()
        if (loginInfo == nil)
        {
            return false
        }
        
        if (!((loginInfo == nil) || (loginInfo?.expireDate?.compare(NSDate()) == NSComparisonResult.OrderedAscending)))
        {
            return false
        }
        
        return true
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
