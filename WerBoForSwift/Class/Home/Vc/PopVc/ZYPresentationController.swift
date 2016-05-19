//
//  ZYPresentationController.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/3.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYPresentationController: UIPresentationController {
    
    
    var presentFrame: CGRect = CGRectZero
    
    
    //MARK: ----lazy
    
    private lazy var coverView: UIView = {
        let coverView = UIView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight))
        coverView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        let tap = UITapGestureRecognizer(target: self, action: #selector(ZYPresentationController.clickCoverView))
        
        coverView.addGestureRecognizer(tap)
        
        return coverView
    }()
    
    
    
    /**
     初始化方法, 用于创建负责转场动画的对象
     
     :param: presentedViewController  被展现的控制器
     :param: presentingViewController 发起的控制器, Xocde6是nil, Xcode7是野指针
     
     :returns: 负责转场动画的对象
     */
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController)
    {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
    
    /**
     即将布局转场子视图时调用
     */
    override func containerViewWillLayoutSubviews() {
        
        //修改弹出的presentedView的尺寸
        if (presentFrame == CGRectZero)
        {
            presentedView()?.frame = CGRectMake(100, 50, 150, 200)
        }
        else
        {
            presentedView()?.frame = presentFrame
        }
        
        //在容器View里面添加遮盖
        containerView?.insertSubview(coverView, atIndex: 0)
    }
    
    //MARK: ----click
    @objc private func clickCoverView()
    {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
