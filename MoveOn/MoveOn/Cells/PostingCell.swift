//
//  PostingCell.swift
//  MoveOn
//
//  Created by 심주미 on 2022/01/17.
//

import UIKit

protocol PostingCellDelegate: AnyObject {
    func goComment()
}

class PostingCell: UITableViewCell {
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var commentButton: UIButton!
    
    weak var delegate:CommunityViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //commentButton.addTarget(self, action: #selector(goCommentView), for: .touchUpInside)
        
    }
    
    func setData(data:PostModel){
        nicknameLabel.text = data.nickname
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
