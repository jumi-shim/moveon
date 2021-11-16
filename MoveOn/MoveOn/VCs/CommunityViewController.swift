//
//  CommunityViewController.swift
//  MoveOn
//
//  Created by 심주미 on 2021/11/14.
//

import UIKit

class CommunityViewController: UITableViewController {
    @IBOutlet var communityTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let communityNameLabel = UILabel()
        communityNameLabel.text = "건물이름"
        communityNameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: communityNameLabel)
        
        communityTableView.register(UINib(nibName: "HashtagCell", bundle: nil), forCellReuseIdentifier: "HashtagCell")
        communityTableView.register(UINib(nibName: "PostingCell", bundle: nil), forCellReuseIdentifier: "PostingCell")
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cells: [HashtagCell]
            for i in 1...10{
                cells.append(tableView.dequeueReusableCell(withIdentifier: "HashtagCell", for: indexPath) as! HashtagCell)
            }
            
            return UITableViewCell cells
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostingCell", for: indexPath)
            return cell
        }
    }
    
    
}




