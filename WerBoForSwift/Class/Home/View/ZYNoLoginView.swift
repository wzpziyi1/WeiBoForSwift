//
//  ZYNoLoginView.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/4/15.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

protocol ZYNoLoginViewDelegate : NSObjectProtocol
{
    func noLoginViewDidClickRegistBtn()
    func noLoginViewDidClickLoginBtn()
}

class ZYNoLoginView: UIView {
    @IBOutlet weak var customView: UIView!
    
    @IBOutlet weak var iconView: UIImageView!
    
    weak var delegate: ZYNoLoginViewDelegate?
    
    class func createNoLoginView() ->UIView
    {
        return self.init()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.commitInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commitInit()
    {
        NSBundle.mainBundle().loadNibNamed("ZYNoLoginView", owner: self, options: nil)
        addSubview(customView)
        customView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
        beginAnimation()
    }
    
    private func beginAnimation()
    {
        let basicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        basicAnimation.toValue = 2 * M_PI
        
        basicAnimation.duration = 10
        basicAnimation.removedOnCompletion = false
        basicAnimation.repeatCount = MAXFLOAT
        
        iconView.layer.addAnimation(basicAnimation, forKey: nil)
    }
    
    @IBAction func clickRegistBtn(sender: AnyObject) {
        self.delegate?.noLoginViewDidClickRegistBtn()
    }
    
    @IBAction func clickLoginBtn(sender: AnyObject) {
        self.delegate?.noLoginViewDidClickLoginBtn()
    }
    
}
