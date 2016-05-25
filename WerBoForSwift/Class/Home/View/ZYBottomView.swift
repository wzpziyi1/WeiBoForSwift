//
//  ZYBottomView.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/25.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYBottomView: UIView {
    
    @IBOutlet weak var customView: UIView!
    
    @IBOutlet weak var commentBtn: UIButton!
    
    @IBOutlet weak var supportBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func commitInit()
    {
        NSBundle.mainBundle().loadNibNamed("ZYBottomView", owner: self, options: nil)
        addSubview(customView)
        customView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
    }
    
    /**
     转发微博
     */
    @IBAction func relayStatus(sender: UIButton)
    {
        
    }
    
    /**
     评论微博
     */
    @IBAction func commentStatus(sender: UIButton)
    {
        
    }
    
    /**
     点赞
     */
    @IBAction func supportStatus(sender: UIButton)
    {
        
    }
    
    
}
