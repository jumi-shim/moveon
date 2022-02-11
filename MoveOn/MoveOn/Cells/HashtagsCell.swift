//
//  HashtagsCell.swift
//  MoveOn
//
//  Created by 심주미 on 2021/11/16.
//

import UIKit
import RxSwift
import RxCocoa

class HashtagsCell: UITableViewCell {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let communityTagPostsVM = CommunityTagPostsViewModel()
    let disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //collectionView.dataSource = self
        //collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "HashtagCell", bundle: nil), forCellWithReuseIdentifier: "HashtagCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        layout.itemSize = CGSize(width: 270, height: 125)
        collectionView.collectionViewLayout = layout
        
        communityTagPostsVM.tagPostSubject
            .bind(to: collectionView.rx.items(cellIdentifier: "HashtagCell", cellType: HashtagCell.self)) {_, element, cell in
                cell.configure(data: element)
            }
            .disposed(by: disposeBag)
        communityTagPostsVM.populateTagPosts()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
/*
extension HashtagsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HashtagCell", for: indexPath)
    
        return cell
    }
    
    
}*/
