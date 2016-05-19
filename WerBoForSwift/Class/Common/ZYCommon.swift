//
//  ZYCommon.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/4/7.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.mainScreen().bounds.size.width

let kScreenHeight = UIScreen.mainScreen().bounds.size.height

//Library目录
let kLibraryPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory, NSSearchPathDomainMask.UserDomainMask, true).last

//Document目录
let kDocumentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last

//Cache目录
let kCachePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last


//命名空间
let kSpaceName = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String



func ZYColor(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor
{
    return ZYColor(r, g: g, b: b, alpha: 1)
}

func ZYColor(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) -> UIColor
{
    return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: alpha)
}
