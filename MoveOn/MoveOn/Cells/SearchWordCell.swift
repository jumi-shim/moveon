//
//  SearchWordCell.swift
//  MoveOn
//
//  Created by 심주미 on 2021/11/21.
//

import UIKit

class SearchWordCell: UICollectionViewCell {

    
    @IBOutlet weak var searchWordLabel: UILabel!
    
    @IBOutlet weak var searchWordView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //let searchWordLabelHeight = 20
        
        searchWordView.layer.cornerRadius = 25/2
        searchWordView.clipsToBounds = true
    }
}
