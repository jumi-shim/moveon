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
        
      
        
        //let layout = UICollectionViewFlowLayout()
        //layout.itemSize = CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        communityTableView.register(UINib(nibName: "HashtagsCell", bundle: nil), forCellReuseIdentifier: "HashtagsCell")
        communityTableView.register(UINib(nibName: "PostingCell", bundle: nil), forCellReuseIdentifier:"PostingCell")
        //communityTableView.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
        
        
        
       
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

    @objc func goComment() {
        let commentVC = self.storyboard?.instantiateViewController(withIdentifier: "CommentNavigationController")
        guard let commentVC = commentVC else { return }
        commentVC.modalPresentationStyle = .fullScreen
        present(commentVC, animated: true)
        
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
            //cell.delegate = self
            cell.commentButton.addTarget(self, action: #selector(goComment), for: .touchUpInside)
            cell.setData(data: postingDatas[indexPath.row])
            
            return cell
        }/*else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
            return cell
        }*/
    }
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let cell = communityTableView.cellForRow(at: indexPath) as! PostingCell
            
            
        }
    }*/
    
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
