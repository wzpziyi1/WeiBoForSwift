//
//  ZYMyCardVc.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/5.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit
import SDWebImage

class ZYMyCardVc: UIViewController {

    @IBOutlet weak var codeView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var iconView: UIImageView!
    
    init(){
        super.init(nibName: "ZYMyCardVc", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        iconView.layer.borderWidth = 2
        iconView.layer.borderColor = UIColor.whiteColor().CGColor
        
        setupNavigationBar()
        
        setupQRCodeView()
    }
    
    //MARK: ----setup
    private func setupNavigationBar()
    {
        navigationItem.title = "我的名片"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ZYMyCardVc.clickLeftItem))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "分享", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ZYMyCardVc.clickRightItem))
    }
    
    
    /**
     生成二维码过程
     */
    private func setupQRCodeView()
    {
        //创造滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        // 还原滤镜的默认属性
        filter?.setDefaults()
        
        // 设置需要生成二维码的数据
        filter?.setValue("沧海行舟".dataUsingEncoding(NSUTF8StringEncoding), forKey: "inputMessage")
        
        // 从滤镜中取出生成好的图片
        let ciImage = filter?.outputImage
        
        let bgImage = createNonInterpolatedUIImageFormCIImage(ciImage!, size: 400)
        
        // 创建一个头像
        let urlStr = ZYSaveTool.sharedSaveTool().readUserInfo()?.avatar_large
        var icon: UIImage!
        if (urlStr == nil)
        {
            icon = UIImage(named: "avatar_default_big")
        }
        else
        {
            let isExisting = SDWebImageManager.sharedManager().diskImageExistsForURL(NSURL(string: urlStr!))
            if (isExisting)
            {
                icon = SDImageCache.sharedImageCache().imageFromDiskCacheForKey(urlStr!)
            }
            else
            {
                icon = UIImage(named: "avatar_default_big")
            }
        }
        
        iconView.image = icon
        
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            // 合成图片(将二维码和头像进行合并)
            self.createImageWithBgImage(bgImage, iconImage: icon!)
        }
    }
    
    //MARKL ----click
    @objc private func clickLeftItem()
    {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @objc private func clickRightItem()
    {
        print(#function)
    }
    
    //MARK: ----二维码相关操作
    
    
    /**
    根据CIImage生成指定大小的高清UIImage
    
    :param: image 指定CIImage
    :param: size    指定大小
    :returns: 生成好的图片
    */
    private func createNonInterpolatedUIImageFormCIImage(image: CIImage, size: CGFloat) -> UIImage {
        
        let extent: CGRect = CGRectIntegral(image.extent)
        let scale: CGFloat = min(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent))
        
        // 创建bitmap;
        let width = CGRectGetWidth(extent) * scale
        let height = CGRectGetHeight(extent) * scale
        let cs: CGColorSpaceRef = CGColorSpaceCreateDeviceGray()!
        let bitmapRef = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, cs, 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImageRef = context.createCGImage(image, fromRect: extent)
        
        CGContextSetInterpolationQuality(bitmapRef,  CGInterpolationQuality.None)
        CGContextScaleCTM(bitmapRef, scale, scale);
        CGContextDrawImage(bitmapRef, extent, bitmapImage);
        
        // 保存bitmap到图片
        let scaledImage: CGImageRef = CGBitmapContextCreateImage(bitmapRef)!
        
        return UIImage(CGImage: scaledImage)
    }
    
    
    /**
     合成图片
     
     - parameter bgImage:   背景图片
     - parameter iconImage: 中心图片
     
     */
    private func createImageWithBgImage(bgImage: UIImage, iconImage: UIImage)
    {
        UIGraphicsBeginImageContext(bgImage.size)
        
        bgImage.drawInRect(CGRectMake(0, 0, bgImage.size.width, bgImage.size.height))
        
        let x: CGFloat = (bgImage.size.width - 55) * 0.5
        let y: CGFloat = (bgImage.size.height - 55) * 0.5
        
        
        iconImage.drawInRect(CGRectMake(x, y, 55, 55))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.codeView.image = image
        }
    }
}

