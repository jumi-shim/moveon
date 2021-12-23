//
//  EditPostingViewController.swift
//  MoveOn
//
//  Created by 심주미 on 2021/11/18.
//

import UIKit

class EditPostingViewController: UIViewController {

    @IBOutlet weak var titleBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var finishBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationItem()
        makePhotoCollectionViewLayout()
        photoCollectionView.dataSource = self
        
        photoCollectionView.layer.shadowOffset = CGSize(width: 0, height: 10)
        photoCollectionView.layer.shadowOpacity = 0.1
        photoCollectionView.layer.masksToBounds = false
        
    }
    func makePhotoCollectionViewLayout(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        layout.itemSize = CGSize(width: 270, height: 270)
        photoCollectionView.collectionViewLayout = layout
    }
    
    func makeNavigationItem(){
        let title = UILabel()
        title.text = "글쓰기"
        title.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleBarButtonItem.customView = title
        
        
        let finishLabel = UILabel()
        let shadowLabel = UILabel()
        
        finishLabel.text = "완료"
        finishLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        finishLabel.backgroundColor = UIColor(red: 255/255, green: 174/255, blue: 174/255, alpha: 1)
        finishLabel.frame.size.width = 80
        finishLabel.frame.size.height = 35
        finishLabel.layer.cornerRadius = 35/2
        finishLabel.textAlignment = .center
        finishLabel.clipsToBounds = true
        
        shadowLabel.frame.size.width = 80
        shadowLabel.frame.size.height = 35
        shadowLabel.layer.masksToBounds = false
        shadowLabel.layer.shadowColor = UIColor.black.cgColor
        shadowLabel.layer.shadowOffset = CGSize(width: 2, height: 4)
        shadowLabel.layer.shadowOpacity = 0.07
        shadowLabel.layer.shadowRadius = 1.5
        shadowLabel.addSubview(finishLabel)
        
        finishBarButtonItem.customView = shadowLabel
    }
    @IBAction func closeView(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

}

extension EditPostingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        return cell
    }
}
