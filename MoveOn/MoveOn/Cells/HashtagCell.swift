//
//  HashtagCell.swift
//  MoveOn
//
//  Created by 심주미 on 2021/11/14.
//

import UIKit

class HashtagCell: UITableViewCell {

    @IBOutlet weak var profileImg1: UIImageView!
    @IBOutlet weak var profileImg2: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let profileHeight: CGFloat = 60
        profileImg1.layer.cornerRadius = profileHeight/2
        profileImg2.layer.cornerRadius = profileHeight/2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
