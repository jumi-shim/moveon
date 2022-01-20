//
//  PostingCell.swift
//  MoveOn
//
//  Created by 심주미 on 2022/01/17.
//

import UIKit

class PostingCell: UITableViewCell {
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setData(data:PostModel){
        nicknameLabel.text = data.nickname
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
