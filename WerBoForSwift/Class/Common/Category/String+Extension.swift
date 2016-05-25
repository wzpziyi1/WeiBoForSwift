//
//  String+Extension.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/19.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import Foundation

extension String {
    
    func cachePath() ->String
    {
        return (kCachePath! as NSString).stringByAppendingPathComponent(self)
    }
    
    func documentPath() ->String
    {
        return (kDocumentPath! as NSString).stringByAppendingPathComponent(self)
    }
    
    func libraryPath() ->String
    {
        return (kLibraryPath! as NSString).stringByAppendingPathComponent(self)
    }
    
}