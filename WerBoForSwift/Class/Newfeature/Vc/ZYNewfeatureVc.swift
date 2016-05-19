//
//  ZYNewfeatureVc.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/11.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYNewfeatureVc: UIViewController {

    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var currentIndex:Int = 0
    
    private lazy var images:[UIImage] = {
        var images = Array<UIImage>()
        
        for (var i = 1; i <= 4; i += 1)
        {
            let fileName = "new_feature_\(i)"
            
            images.append(UIImage(named: fileName)!)
        }
        return images
    }()
    
    private lazy var currentImgView: UIImageView = UIImageView(frame: UIScreen.mainScreen().bounds)
    
    private lazy var otherImgView: UIImageView = UIImageView(frame: UIScreen.mainScreen().bounds)
    
    private lazy var enterBtn: UIButton = {
        let btn = UIButton()
        btn.frame = CGRectMake(0, 0, 150, 60)
        
        btn.center.x = kScreenWidth + self.view.center.x
        btn.center.y = kScreenHeight - 150
        btn.hidden = true
        
        btn.setBackgroundImage(UIImage(named: "new_feature_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "new_feature_button_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(self, action: #selector(ZYNewfeatureVc.clickEnterBtn), forControlEvents: UIControlEvents.TouchUpInside)
        self.scrollView.addSubview(btn)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupScrollView()
        
        pageControl.numberOfPages = images.count
    }
    
    private func setupScrollView()
    {
        scrollView.delegate = self
        scrollView.contentSize = CGSizeMake(3 * kScreenWidth, kScreenHeight)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.pagingEnabled = true
        scrollView.bounces = false
        scrollView.contentOffset = CGPointMake(kScreenWidth, 0)
        currentImgView.image = UIImage(named: "new_feature_1")
        currentImgView.frame.origin.x = kScreenWidth
        scrollView.addSubview(currentImgView)
        scrollView.addSubview(otherImgView)
        currentIndex = 0
        
    }
    
    @objc private func clickEnterBtn()
    {
        let window = UIApplication.sharedApplication().keyWindow
        window?.rootViewController = ZYTabBarVc()
    }
    
}

extension ZYNewfeatureVc: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.x < kScreenWidth)
        {
            let index = (currentIndex - 1 + images.count) % images.count
            otherImgView.image = images[index]
            otherImgView.frame.origin.x = 0
        }
        
        if (scrollView.contentOffset.x > kScreenWidth)
        {
            let index = (currentIndex + 1 + images.count) % images.count
            otherImgView.image = images[index]
            otherImgView.frame.origin.x = 2 * kScreenWidth
        }
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        
        if (scrollView.contentOffset.x == 0.0)
        {
            currentImgView.image = otherImgView.image
            otherImgView.image = nil
            scrollView.contentOffset.x = kScreenWidth
            currentIndex = (currentIndex - 1 + images.count) % images.count
        }
        
        if (scrollView.contentOffset.x == kScreenWidth * 2)
        {
            currentImgView.image = otherImgView.image
            otherImgView.image = nil
            scrollView.contentOffset.x = kScreenWidth
            currentIndex = (currentIndex + 1 + images.count) % images.count
        }
        if (currentIndex == images.count - 1)
        {
            enterBtn.hidden = false
        }
        else
        {
            enterBtn.hidden = true
        }
        
        pageControl.currentPage = currentIndex
    
    }
}
