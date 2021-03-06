//
//  CommunityViewController.swift
//  MoveOn
//
//  Created by 심주미 on 2021/11/14.
//

import UIKit

class CommunityViewController: UIViewController {
    
    @IBOutlet var communityTableView: UITableView!
    var api = API()
    
    let communityPostsVM = CommunityPostsViewModel()
    
    var postingDatas:[Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savePostingDatas()
        
        communityTableView.delegate = self
        communityTableView.dataSource = self
        
        let communityNameLabel = UILabel()
        communityNameLabel.text = "건물이름"
        communityNameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: communityNameLabel)
        
        
        communityTableView.register(UINib(nibName: "HashtagsCell", bundle: nil), forCellReuseIdentifier: "HashtagsCell")
        //communityTableView.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
        //communityTableView.register(PostingCell.self, forCellReuseIdentifier: "PostingCell")
        
        /*let dataSource = CommunityViewController.dataSource()
        
        communityPostsVM.postSubject.bind(to: communityTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        communityPostsVM.populatePosts()*/
        /*communityTableView.rx.setDelegate(self).disposed(by: disposeBag)
        communityPostsVM.postSubject.bind(to: communityTableView.rx.items){(tableView, row, item) -> UITableViewCell in
            if row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HashtagsCell") as! HashtagsCell
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PostingCell") as! PostingCell
                //cell.setData(data: item)
                //cell.nicknameLabel?.text = item.nickname
                //cell.contentLabel?.text = item.content
                return cell
            }
        }.disposed(by: disposeBag)
        communityPostsVM.populatePosts()*/
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

// MARK: RxDataSource
/*
extension CommunityViewController {
    
    static func dataSource() -> RxTableViewSectionedReloadDataSource<CommunitySectionModel> {
        return RxTableViewSectionedReloadDataSource<CommunitySectionModel>(
        configureCell: { (datasource, tableView, indexPath, item) in
            switch datasource[indexPath] {
            case let .TagItem(_) :
                let cell = tableView.dequeueReusableCell(withIdentifier: "HashtagsCell", for: indexPath) as! HashtagsCell
                return cell
            case let .PostItem(nickname, content) :
                let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostingCell
                cell.nicknameLabel.text = nickname
                cell.contentLabel.text = content
                return cell
            }
        })
    }
}*/
    

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
            //print(indexPath.row, postingDatas.count, postingDatas)
            
            cell.setData(data: postingDatas[indexPath.row])
            cell.commentActionBlock = {
                let commentVC = self.storyboard?.instantiateViewController(withIdentifier: "CommentViewController") as! CommentViewController
                commentVC.commentPostId = String(self.postingDatas[indexPath.row].postId)
                self.navigationController?.pushViewController(commentVC, animated: true)
            }
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
            return 150
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

