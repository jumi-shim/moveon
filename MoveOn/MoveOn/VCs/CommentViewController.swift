//
//  CommentViewController.swift
//  MoveOn
//
//  Created by 심주미 on 2022/01/25.
//

import Foundation
import UIKit

class CommentViewController: UIViewController {
    
    @IBOutlet weak var commentTableView: UITableView!
    
    var commentListViewModel:CommentViewListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTableView.delegate = self
        commentTableView.dataSource = self
        loadComment()
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func loadComment(){
        API().getComments { [self] comments in
            guard let comments = comments else {
                return
            }
            self.commentListViewModel = CommentViewListModel(comments: comments)
            DispatchQueue.main.async {
                commentTableView.reloadData()
                print("commentTableView reload")
            }
        }
    }
    
}

extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentListViewModel?.numberOfRows(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentTableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        guard let commentListViewModel = commentListViewModel else { return cell }
        cell.configure(commentListViewModel.modelAt(indexPath.row))
        return cell
    }
    
    
}
