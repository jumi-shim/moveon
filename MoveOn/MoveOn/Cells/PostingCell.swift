//
//  PostingCell.swift
//  MoveOn
//
//  Created by 심주미 on 2022/01/17.
//

import UIKit


class PostingCell: UITableViewCell {
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    weak var delegate:CommunityViewController?
    var postId = ""
    var commentActionBlock: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //commentButton.addTarget(self, action: #selector(goCommentView), for: .touchUpInside)
        
    }
    
    func setData(data:Post){
        nicknameLabel.text = data.nickname
        contentLabel.text = data.content
        postId = String(data.postId)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func goComment(_ sender: Any) {
        commentActionBlock?()
    }
    
}
