//
//  HomeCell.swift
//  Jet2TT_Test
//
//  Created by Ankit on 06/10/2020.
//  Copyright © 2020 Ankit. All rights reserved.
//


import UIKit


class HomeCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDesgination: UILabel!
    @IBOutlet weak var imgViewProfile: UIImageView!
    @IBOutlet weak var imgViewArticle: UIImageView!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUrl: UILabel!
    @IBOutlet weak var constImageArticle: NSLayoutConstraint!
    @IBOutlet weak var constImageTitle: NSLayoutConstraint!
    @IBOutlet weak var constUrl: NSLayoutConstraint!
    
    var modal : Blogs?{
        didSet{
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        
    }
    
    func configureCell(){
        let date = modal?.createdAt?.stringToDate(format: .ZZ)
        lblTime.text = date?.compareWith(date: Date.init())
        if let user = modal?.user?[0] {
            lblName.text = user.name
            imgViewProfile.loadURL(urlString:  user.avatar, placeholderImage: nil)
            imgViewProfile.layer.cornerRadius = imgViewProfile.frame.width/2.0
            imgViewProfile.layer.masksToBounds = true
            lblDesgination.text = user.designation
        }
            
        if modal?.media!.count ?? 0 > 0 {
            if let media = modal?.media?[0]{
                constImageArticle.constant = 150
                imgViewArticle.isHidden = false
                lblTitle.isHidden = false
                lblUrl.isHidden = false
                imgViewArticle.loadURL(urlString:  media.image, placeholderImage: nil)
                lblTitle.text = media.title
                lblUrl.text = media.url
            }
        }else{
            imgViewArticle.isHidden = true
            lblTitle.isHidden = true
            lblTitle.frame = CGRect.zero
            lblUrl.frame = CGRect.zero
            lblUrl.isHidden = true
            constImageArticle.constant = 0
            constImageTitle.constant = 0
            constUrl.constant = 0 
        }
        lblContent.text = modal?.content ?? ""
        lblComment.text = "\(/modal?.comments) Comments"
        lblLike.text = "\(/modal?.likes) Likes"
    }
    
}
