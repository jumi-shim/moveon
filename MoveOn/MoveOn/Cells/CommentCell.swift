//
//  CommentCell.swift
//  MoveOn
//
//  Created by 심주미 on 2022/01/25.
//

import Foundation
import UIKit

class CommentCell:UITableViewCell {
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var contentLable: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(_ vm: CommentsModel) {
        contentLable.text = vm.nickname + vm.content
        //profileImgView.image =
    }
    
    
}
