//
//  ZYBaseTableVc.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/4/7.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYBaseTableVc: UITableViewController, ZYNoLoginViewDelegate {

    var isLogin : Bool = ZYSaveTool.sharedSaveTool().isLogin()
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
    
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: -setup系列
    private func setupNoLoginView()
    {
        noLoginView = ZYNoLoginView.createNoLoginView() as! ZYNoLoginView
        view = noLoginView
        noLoginView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight)
        noLoginView.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ZYBaseTableVc.clickLeftBarItem))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ZYBaseTableVc.clickRightBarItem))
    }
    
    
    //MARK: ----Click
    
    @objc private func clickLeftBarItem()
    {
        print(#function)
    }
    
    @objc private func clickRightBarItem()
    {
        let vc = ZYOAuthVC()
        let nvc = UINavigationController(rootViewController: vc)
        presentViewController(nvc, animated: true, completion: nil)
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
