//
//  ZYStatusCell.swift
//  WerBoForSwift
//
//  Created by 王志盼 on 16/5/24.
//  Copyright © 2016年 王志盼. All rights reserved.
//

import UIKit

class ZYStatusCell: UITableViewCell {
    
    let defaultHeigt: CGFloat = 80
    
    var photoConstraintH: NSLayoutConstraint!
    
    var photoConstraintTop: NSLayoutConstraint!
    
    var statusInfo: ZYStatusInfo! {
        didSet{
            setInfoForCell()
            
            setPosition()
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
    
    private lazy var photoView: ZYPhotoView = ZYPhotoView(frame: CGRectZero)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = UITableViewCellSelectionStyle.None
        
        iconView.layer.cornerRadius = iconView.frame.size.width / 2
        iconView.layer.masksToBounds = true
        
        addSubview(photoView)
        photoConstraintTop = photoView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: contentLabel, withOffset: 10)
        photoView.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 10)
        photoView.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 10)
        photoConstraintH = photoView.autoSetDimension(ALDimension.Height, toSize: 0)
        
        addSubview(bottomView)
        bottomView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: photoView, withOffset: 10)
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
    
    private func setInfoForCell()
    {
        iconView.sd_setImageWithURL(NSURL(string: statusInfo.user!.avatar_large!), placeholderImage: UIImage(named: "avatar_default_big"))
        nameLabel.text = statusInfo.user!.screen_name
        timeLabel.text = statusInfo.created_at
        sourceLabel.text = statusInfo.source
        contentLabel.text = statusInfo.text
        
        if (statusInfo.pic_urls == nil || statusInfo.pic_urls?.count == 0)
        {
            photoView.hidden = true
        }
        else
        {
            photoView.picInfos = statusInfo.pic_urls
            photoView.name = nameLabel.text
            photoView.hidden = false
        }
    }
    
    private func setPosition()
    {
//        print("name= \(statusInfo.user?.screen_name)\n  pics= \(statusInfo.pic_urls?.count)\n  url= \(statusInfo.pic_urls?.first?.thumbnail_pic)\n\n")
        if (statusInfo.pic_urls == nil || statusInfo.pic_urls?.count == 0)
        {
            photoConstraintTop.constant = 0
            photoConstraintH.constant = 0
        }
        else
        {
            photoConstraintTop.constant = 10
            photoConstraintH.constant = defaultHeigt * (CGFloat)((statusInfo.pic_urls!.count - 1) / 3 + 1) + 10 * (CGFloat)(statusInfo.pic_urls!.count / 3)
        }
        layoutIfNeeded()
    }
}
