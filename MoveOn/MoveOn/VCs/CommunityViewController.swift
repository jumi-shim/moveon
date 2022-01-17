//
//  CommunityViewController.swift
//  MoveOn
//
//  Created by 심주미 on 2021/11/14.
//

import UIKit

class CommunityViewController: UIViewController{
    
    @IBOutlet var communityTableView: UITableView!
    var api = API()
    
    var postingDatas:[PostModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savePostingDatas()
        
        communityTableView.delegate = self
        communityTableView.dataSource = self
        
        let communityNameLabel = UILabel()
        communityNameLabel.text = "건물이름"
        communityNameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: communityNameLabel)
        
        /*
        //let editPostingImg = UIImage(named: "EditPostingImg")?.withRenderingMode(.alwaysOriginal)
        let editPostingImg = UIImage(systemName: "pencil")?.withRenderingMode(.alwaysOriginal)
        let editPostingItem = UIBarButtonItem.init(image: editPostingImg, style: .done, target: self, action: #selector(goToEditPosting))
        let searchImg = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysOriginal)
        let searchItem = UIBarButtonItem.init(image: searchImg, style: .done, target: self, action: #selector(goToSearch))

        
        //editPostingItem.imageInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        searchItem.imageInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -20)
        self.navigationItem.rightBarButtonItems = [editPostingItem, searchItem]
        */
        
        //let layout = UICollectionViewFlowLayout()
        //layout.itemSize = CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        communityTableView.register(UINib(nibName: "HashtagsCell", bundle: nil), forCellReuseIdentifier: "HashtagsCell")
        communityTableView.register(UINib(nibName: "PostingCell", bundle: nil), forCellReuseIdentifier:"PostingCell")
        //communityTableView.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
        
        
        
        /*
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: 80, height: 30)
        searchWordCollectionView.collectionViewLayout = layout*/
        
        /*
        for _ in 1...2 {
            let searchWord = UILabel()
            searchWord.text = "완료"
            searchWord.backgroundColor = UIColor(red: 255/255, green: 174/255, blue: 174/255, alpha: 1)
            searchWord.frame.size.width = 60
            searchWord.frame.size.height = 25
            searchWord.layer.cornerRadius = 25/2
            searchWord.textAlignment = .center
            searchWord.clipsToBounds = true
            
            searchWordStackView.addArrangedSubview(searchWord)
            
        }*/
        
    }
    
    func savePostingDatas() {
        
        api.loadPost { postModels in
            if let datas = postModels{
                self.postingDatas.append(contentsOf: datas)
                self.communityTableView.reloadData()
            }
        }
    }
    
    @objc func goToSearch(){
        
    }

}

extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return postingDatas.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HashtagsCell", for: indexPath)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostingCell", for: indexPath) as! PostingCell
            print(indexPath.row, postingDatas.count, postingDatas)
            cell.setData(data: postingDatas[indexPath.row])
            
            return cell
        }/*else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
            return cell
        }*/
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 250
        }
        return UITableView.automaticDimension
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        if offsetY > (contentHeight - height) {
            savePostingDatas()
        }
    }
}



