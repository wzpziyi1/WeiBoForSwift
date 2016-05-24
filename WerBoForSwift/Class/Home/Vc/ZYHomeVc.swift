//
//  ZYHomeVc.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/4/6.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYRightImgBtn: UIButton{
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRectMake(0, contentRect.origin.y, contentRect.size.width, contentRect.size.height)
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        
//        print(contentRect)
        return CGRectMake(bounds.size.width - 13, (contentRect.size.height - 12) / 2, 13, 12)
    }
    
}

class ZYHomeVc: ZYBaseTableVc {
    
    let accountInfo = ZYSaveTool.sharedSaveTool().readUserInfo()
    let loginInfo = ZYSaveTool.sharedSaveTool().readLoginInfo()
    
    
    //MARK: ----life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if (isLogin)
        {
            setupNavigationBar()
            
            //KVO监听poperAnimation对象中isPresenting的变化，相应改变箭头的方向
            poperAnimation.addObserver(self, forKeyPath: "isPresenting", options: .New, context: nil)
            
            tableView.registerNib(UINib.init(nibName: "ZYStatusCell", bundle: nil), forCellReuseIdentifier: "ZYStatusCell")
        }
        
    }
    
    deinit{
        poperAnimation.removeObserver(self, forKeyPath: "isPresenting")
    }
    
    
    //MARK: ----lazy
    private lazy var poperVc: ZYPoperVc = ZYPoperVc(nibName: "ZYPoperVc", bundle: nil)
    
    private lazy var poperAnimation: ZYPoperAnimation = ZYPoperAnimation()
    
    private lazy var titleView: ZYRightImgBtn = {
        let titleView = ZYRightImgBtn(type: UIButtonType.Custom)
        titleView.adjustsImageWhenHighlighted = false
        titleView.contentMode = UIViewContentMode.Center
        titleView.titleLabel?.font = UIFont.boldSystemFontOfSize(18)
        titleView.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        titleView.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        titleView.setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
        
        titleView.addTarget(self, action: #selector(ZYHomeVc.clickTitleView(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return titleView
    }()
    
    //MARK: ----setup
    private func setupNavigationBar()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem.createBarButtonWithImageName("navigationbar_friendattention", target: self, action: #selector(ZYHomeVc.clickLeftItem))
        navigationItem.rightBarButtonItem = UIBarButtonItem.createBarButtonWithImageName("navigationbar_pop", target: self, action: #selector(ZYHomeVc.clickRightItem))
        
        titleView.setTitle(accountInfo?.screen_name, forState: UIControlState.Normal)
        
        titleView.sizeToFit()
        titleView.frame.size.width += 5
        navigationItem.titleView = titleView
    }
    
    
    //MARK: ----click
    
    @objc private func clickLeftItem()
    {
        print(#function)
    }
    
    @objc private func clickRightItem()
    {
        let vc = ZYQRCodeVc(nibName: "ZYQRCodeVc", bundle: nil)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func clickTitleView(titleView: ZYRightImgBtn)
    {
        titleView.selected = !titleView.selected
        
        if (titleView.selected)
        {
            //要自定义转场动画，那么首先要设置代理
            poperVc.transitioningDelegate = poperAnimation
            
            poperAnimation.presentFrame = CGRectMake((kScreenWidth - 200) / 2, 55, 200, 250)
            //然后设置为自定义动画
            poperVc.modalPresentationStyle = UIModalPresentationStyle.Custom
            
            titleView.selected ? presentViewController(poperVc, animated: true, completion: nil) : dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    //MARK: ----KVO处理
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        let tmpObj: ZYPoperAnimation? = object as? ZYPoperAnimation
        if (keyPath == "isPresenting" && tmpObj != nil && tmpObj! == poperAnimation)
        {
            let isPresenting = change![NSKeyValueChangeNewKey] as? Bool
            
            if (isPresenting != nil && isPresenting == false)
            {
                titleView.selected = !titleView.selected
            }
            
        }
        else
        {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    
    //MARK: ----网络交互
    
    
    //MARK: ----TableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("ZYStatusCell", forIndexPath: indexPath)
    }
    
}


