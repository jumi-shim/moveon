//
//  CommunityViewController.swift
//  MoveOn
//
//  Created by 심주미 on 2021/11/14.
//

import UIKit

class CommunityViewController: UIViewController{
    @IBOutlet var communityTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        communityTableView.delegate = self
        communityTableView.dataSource = self
        
        let communityNameLabel = UILabel()
        communityNameLabel.text = "건물이름"
        communityNameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: communityNameLabel)
        
        
        let editPostingImg = UIImage(named: "EditPostingImg")?.withRenderingMode(.alwaysOriginal)
        let editPostingItem = UIBarButtonItem.init(image: editPostingImg, style: .done, target: self, action: #selector(goToEditPosting))
        let searchImg = UIImage(named: "SearchImg")?.withRenderingMode(.alwaysOriginal)
        let searchItem = UIBarButtonItem.init(image: searchImg, style: .done, target: self, action: #selector(goToSearch))

        
        editPostingItem.imageInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        searchItem.imageInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: -50)
        self.navigationItem.rightBarButtonItems = [editPostingItem, searchItem]
        
        
        /*
        let editPostingBtn = UIButton()
        editPostingBtn.setImage(UIImage(named: "EditPostingImg"), for: .normal)
        editPostingBtn.addTarget(self, action: #selector(goToEditPosting), for: .touchUpInside)
        
        let searchBtn = UIButton()
        searchBtn.setImage(UIImage(named: "SearchImg"), for: .normal)
        searchBtn.addTarget(self, action: #selector(goToSearch), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [editPostingBtn, searchBtn])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        let coustomItem = UIBarButtonItem(customView: stackView)
        self.navigationItem.rightBarButtonItem = coustomItem
        */
        
        communityTableView.register(UINib(nibName: "HashtagsCell", bundle: nil), forCellReuseIdentifier: "HashtagsCell")
        communityTableView.register(UINib(nibName: "PostingCell", bundle: nil), forCellReuseIdentifier: "PostingCell")
        
    }
    
    @objc func goToEditPosting(){
        let editPostingVC = EditPostingViewController.init(nibName: "EditPostingViewController", bundle: nil)
        editPostingVC.modalPresentationStyle = .fullScreen
        //present(editPostingVC, animated: true, completion: nil)
    }
    
    @objc func goToSearch(){
        
    }

}

extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HashtagsCell", for: indexPath)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostingCell", for: indexPath)
            return cell
        }
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "PostingCell", for: indexPath)
        return cell*/
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 250
        }
        return UITableView.automaticDimension
    }
}



