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
    
    let cellIdentifier = "ZYStatusCell"
    
    let commonCell: ZYStatusCell = NSBundle.mainBundle().loadNibNamed("ZYStatusCell", owner: nil, options: nil).last as! ZYStatusCell
    
    //MARK: ----life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if (isLogin)
        {
            setupNavigationBar()
            
            //KVO监听poperAnimation对象中isPresenting的变化，相应改变箭头的方向
            poperAnimation.addObserver(self, forKeyPath: "isPresenting", options: .New, context: nil)
            
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            tableView.registerNib(UINib.init(nibName: "ZYStatusCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
            
            loadMoreStatus()
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
    
    //所有微博
    private lazy var statusInfos = Array<ZYStatusInfo>()
    
    //缓存cell的height
    private lazy var cellHeights = Array<CGFloat>()
    
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
    func loadMoreStatus()
    {
        
        let params = ["access_token": loginInfo!.access_token!, "count": NSNumber(int: 50)]
        
        ZYHomeNetTool.fetchStatusInfosWithParams(params, succeed: { (result) in
                if (result != nil && result?.count != 0)
                {
                    if (self.statusInfos.count == 0)
                    {
                        for item in result! {
                            self.statusInfos.append(item)
                        }
                    }
                    else
                    {
                        var tempArray = Array<ZYStatusInfo>()
                        for item in result! {
                            tempArray.append(item)
                        }
                        
                        for item in self.statusInfos {
                            tempArray.append(item)
                        }
                        self.statusInfos = tempArray
                    }
                    
                }
                self.calculateHeightForCell()
                self.tableView.reloadData()
            }) { (error) in
                print(error)
        }
        
    }
    
    //MARK: ----other
    private func calculateHeightForCell()
    {
        cellHeights.removeAll()
        for item in statusInfos {
            commonCell.statusInfo = item
            let height = commonCell.fetchHeightFromCell()
            cellHeights.append(height)
        }
    }
    
    //MARK: ----TableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusInfos.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ZYStatusCell
        
        cell.statusInfo = statusInfos[indexPath.row]
        
        return cell
    }
    
    //MARK: ----TableViewDelegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return cellHeights[indexPath.row]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
}


