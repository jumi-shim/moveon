//
//  CommentResponseCell.swift
//  MoveOn
//
//  Created by 심주미 on 2022/01/25.
//

import Foundation
import UIKit

class CommentResponseCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ vm: CommentsModel) {
        contentLabel.text = vm.nickname + "  " + vm.content
    }
}
