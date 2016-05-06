//
//  ZYNetworkTool.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/6.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

import AFNetworking

class ZYNetworkTool: AFHTTPSessionManager {
    
    static let network: ZYNetworkTool = {
        let network = ZYNetworkTool(baseURL: NSURL(string: "https://api.weibo.com/")!)
        
        network.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set<String>
        
        return network
    }()
    
    class func sharedNetworkTool() ->ZYNetworkTool
    {
        return network
    }
}
