//
//  ZYPhotoView.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/25.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYPhotoView: UIView {

    var picInfos: Array<ZYPicInfo>? {
        didSet{
            dealupImageView()
        }
    }
    
    var name: String!
    
    let defaultHeight: CGFloat = 80
    
    private var imageViews = Array<UIImageView>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func dealupImageView()
    {
        var total = 0
        
        if (picInfos?.first?.thumbnail_pic == "http://ww4.sinaimg.cn/thumbnail/7049c17bjw1f47o6iga7og208w08wu0z.gif")
        {
            print("1111111")
        }
        
        for (; total < imageViews.count && total < picInfos!.count; total += 1)
        {
            let imageView = imageViews[total]
            imageView.hidden = false
            
            let urlStr = picInfos![total].thumbnail_pic!
            
            imageView.sd_setImageWithURL(NSURL(string: urlStr), placeholderImage: UIImage(named: "timeline_card_bottom_background"))
        }
        
        if (total < imageViews.count)
        {
            for (; total < imageViews.count; total += 1)
            {
                let imageView = imageViews[total]
                imageView.hidden = true
            }
        }
        
        if (total < picInfos!.count)
        {
            for (; total < picInfos!.count; total += 1)
            {
                let imageView = UIImageView()
                
                let urlStr = picInfos![total].thumbnail_pic!
                
                addSubview(imageView)
                
                imageView.sd_setImageWithURL(NSURL(string: urlStr), placeholderImage: UIImage(named: "timeline_card_bottom_background"))
                imageViews.append(imageView)
            }
        }
        layoutSubviews()
    }
    
    override func layoutSubviews()  {
        super.layoutSubviews()
        
        let margin: CGFloat = 10
        
        let width: CGFloat = (kScreenWidth - 4 * margin) / 3
        
        let height: CGFloat = defaultHeight
        
        for (var i = 0; i < picInfos?.count; i += 1)
        {
            let row = i / 3
            let col = i % 3
            let imageView = imageViews[i]
            imageView.hidden = false
            imageView.frame = CGRectMake((CGFloat)(col) * (margin + width), CGFloat(row) * (margin + height), width, height)
            
//            print("\n  name = \(name)  frame = \(NSStringFromCGRect(imageView.frame)) \n")
        }
    }
    
}
