//
//  ZYStatusCell.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/24.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYStatusCell: UITableViewCell {

    
    var statusInfo: ZYStatusInfo! {
        didSet{
            iconView.sd_setImageWithURL(NSURL(string: statusInfo.user!.avatar_large!), placeholderImage: UIImage(named: "avatar_default_big"))
            nameLabel.text = statusInfo.user!.screen_name
            timeLabel.text = statusInfo.created_at
            sourceLabel.text = statusInfo.source
            contentLabel.text = statusInfo.text
        }
    }
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var vipView: UIImageView!
    
    @IBOutlet weak var vView: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    
    
    
    //MARK: ----lazy
    
    private lazy var bottomView: ZYBottomView = ZYBottomView(frame: CGRectZero)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = UITableViewCellSelectionStyle.None
        
        iconView.layer.cornerRadius = iconView.frame.size.width / 2
        iconView.layer.masksToBounds = true
        
        addSubview(bottomView)
        bottomView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: contentLabel, withOffset: 10)
        bottomView.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 0)
        bottomView.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 0)
        bottomView.autoSetDimension(ALDimension.Height, toSize: 45)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func fetchHeightFromCell()-> CGFloat
    {
        layoutIfNeeded()
        let height = bottomView.frame.size.height + bottomView.frame.origin.y
        return height
    }
    
}
