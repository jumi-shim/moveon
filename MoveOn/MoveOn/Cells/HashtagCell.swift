//
//  HashtagCell.swift
//  MoveOn
//
//  Created by 심주미 on 2021/11/14.
//

import UIKit

class HashtagCell: UICollectionViewCell {

    @IBOutlet weak var tagTitleLabel:UILabel!
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var postTagsLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let profileHeight: CGFloat = 50
        profileImg.layer.cornerRadius = profileHeight/2
    }
    
    func configure(data: TagPost) {
        nicknameLabel.text = data.userNickname
        contentLabel.text = data.postsContent
        tagTitleLabel.text = data.tagContent
    }
    

    
}
