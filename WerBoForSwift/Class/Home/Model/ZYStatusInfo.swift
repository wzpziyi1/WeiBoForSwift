//
//  ZYStatusInfo.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/24.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYStatusInfo: ZYBaseModel {
    var created_at: String?                 //微博创建时间
    var id: NSNumber?                       //微博ID
    var text: String?                       //微博信息内容
    
    var source: String?                     //微博来源
    
    var user: ZYUserInfo?                   //微博作者的用户信息字段
    
    var retweeted_status: ZYStatusInfo?     //被转发的原微博信息字段，当该微博为转发微博时返回
    
    var reposts_count: NSNumber?            //转发数
    
    var comments_count: NSNumber?           //评论数
    
    var attitudes_count: NSNumber?          //表态数
    
    
    var pic_urls: Array<ZYPicInfo>?         //装配图对象的数组
    
//    "pic_urls" =             (
//    {
//    "thumbnail_pic" = "http://ww2.sinaimg.cn/thumbnail/006lzupxjw1f46im0lul1j30m80im0uu.jpg";
//    },
//    {
//    "thumbnail_pic" = "http://ww2.sinaimg.cn/thumbnail/006lzupxjw1f46im0xzjcj30m80j40uu.jpg";
//    },
//    {
//    "thumbnail_pic" = "http://ww4.sinaimg.cn/thumbnail/006lzupxjw1f46im18m03j30ej0m8myz.jpg";
//    }
//    );

    
    override init(dict: Dictionary<String, AnyObject>) {
        super.init(dict: dict)
        setValuesForKeysWithDictionary(dict)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        if (key == "user")
        {
            user = ZYUserInfo(dict: value as! Dictionary<String, AnyObject>)
        }
        else if (key == "retweeted_status")
        {
            retweeted_status = ZYStatusInfo(dict: value as! Dictionary<String, AnyObject>)
        }
        else if (key == "pic_urls")
        {
            var picInfos = Array<ZYPicInfo>()
            
            let tmpValue = value as? Array<AnyObject>
            
            if (tmpValue == nil)
            {
                pic_urls = nil
            }
            else
            {
                for item in tmpValue! {
                    let dict = item as! Dictionary<String, AnyObject>
                    let picInfo = ZYPicInfo(dict: dict)
                    picInfos.append(picInfo)
                }
                pic_urls = picInfos
            }
        }
        else
        {
            super.setValue(value, forKey: key)
        }
    }
    
}
