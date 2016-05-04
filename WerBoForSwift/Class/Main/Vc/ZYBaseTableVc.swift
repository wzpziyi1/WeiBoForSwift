//
//  ZYBaseTableVc.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/4/7.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYBaseTableVc: UITableViewController, ZYNoLoginViewDelegate {

    var isLogin : Bool = true
    var noLoginView : ZYNoLoginView!
    
    //MARK: -life cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        
    }
    
    override func loadView()
    {
        isLogin ? super.loadView() : setupNoLoginView()
    }
    
    //MARK: -setup系列
    private func setupNoLoginView()
    {
        noLoginView = ZYNoLoginView.createNoLoginView() as! ZYNoLoginView
        view = noLoginView
        noLoginView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight)
        noLoginView.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "clickLeftBarItem")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: UIBarButtonItemStyle.Plain, target: self, action: "clickRightBarItem")
    }
    
    @objc private func clickLeftBarItem()
    {
        print(__FUNCTION__)
    }
    
    @objc private func clickRightBarItem()
    {
        print(__FUNCTION__)
    }
    
    //MARK: -ZYNoLoginViewDelegate
    func noLoginViewDidClickRegistBtn()
    {
        clickLeftBarItem()
    }
    
    func noLoginViewDidClickLoginBtn()
    {
        clickRightBarItem()
    }
    
    
}
