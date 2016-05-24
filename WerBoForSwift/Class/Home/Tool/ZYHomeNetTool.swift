//
//  ZYHomeNetTool.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/24.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYHomeNetTool: NSObject {
    
    static let access_token = ZYSaveTool.sharedSaveTool().readLoginInfo()?.access_token!
    
    /**
     获取微博数据
     */
    class func fetchStatusInfosWithParams(params: Dictionary<String, AnyObject>, succeed: ((result: Array<ZYStatusInfo>?) -> ())?, failure: ((error: NSError) -> ())?)
    {
//        let params = ["access_token": access_token!]
        ZYNetworkTool.sharedNetworkTool().GET(kApiStatusInfo, parameters: params, success: { (_, json) in
            var statuses:Array<ZYStatusInfo>? = nil
            let tmpJson = json as? Dictionary<String, AnyObject>
            if (tmpJson != nil)
            {
                
                let tmpInfo = tmpJson!["statuses"] as? Array<AnyObject>
                
                if (tmpInfo != nil)
                {
                    statuses = Array<ZYStatusInfo>()
                    
                    for item in tmpInfo! {
                        let statusInfo = ZYStatusInfo(dict: item as! Dictionary<String, AnyObject>)
                        statuses!.append(statusInfo)
                    }
                }
            }
            
            if (succeed != nil)
            {
                succeed!(result: statuses)
            }
            
            }) { (_, error) in
                print(error)
                
                if (failure != nil)
                {
                    failure!(error: error)
                }
                
        }
    }
}
