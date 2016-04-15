//
//  UIBarButtonItem+Extension.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/4/15.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    class func barButtonWithImageName(imageName: String, target: AnyObject?, action: Selector) ->UIBarButtonItem
    {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "\(imageName + "_highlighted")"), forState: UIControlState.Highlighted)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        
        return UIBarButtonItem(customView: btn)
    }
}
