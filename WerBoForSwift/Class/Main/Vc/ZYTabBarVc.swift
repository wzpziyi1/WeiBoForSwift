//
//  ZYTabBarVc.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/4/6.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYTabBarVc: UITabBarController {

    //MARK: --Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildsVc()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setupComposeBtn()
    }
    
    //MARK: -lazy加载
    private lazy var composeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        btn.addTarget(self, action: #selector(ZYTabBarVc.clickComposeBtn), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    //MARK: -setup
    private func setupChildsVc()
    {
        let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)! as String
        let jsonData: NSData = NSData(contentsOfFile: path)!
        
        do
        {
            let dictArray = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)
            
            for dict in dictArray as! [[String : String]]
            {
                addChildsVc(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
            }
        }
        catch
        {
            print(error)
            
            addChildsVc("ZYHomeVc", title: "首页", imageName: "tabbar_home")
            addChildsVc("ZYMessageVc", title: "消息", imageName: "tabbar_message_center")
            addChildsVc("ZYNullVc", title: "", imageName: "")
            addChildsVc("ZYDiscoverVc", title: "广场", imageName: "tabbar_discover")
            addChildsVc("ZYProfileVc", title: "我", imageName: "tabbar_profile")
        }
        
    }
    
    private func setupComposeBtn()
    {
        tabBar.addSubview(composeBtn)
        let width = kScreenWidth / 5.0
        
        composeBtn.frame = CGRectMake(width * 2, 0, width, 49)
    }
    
    //MARK: -other
    
    private func addChildsVc(vcStr: String, title: String, imageName: String)
    {
        //获取命名空间
//        print(kSpaceName);
        
        let cla: AnyClass? = NSClassFromString(kSpaceName + "." + vcStr)
        
        let calssVc = cla as! UIViewController.Type
        
        let vc = calssVc.init()
        
        vc.title = title;
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: (imageName + "_highlighted"))
        
        let nvc = UINavigationController(rootViewController: vc)
        
        addChildViewController(nvc)
    }
    
    //MARK: -click事件处理
    @objc private func clickComposeBtn()
    {
        print(#function)
    }
    
}
