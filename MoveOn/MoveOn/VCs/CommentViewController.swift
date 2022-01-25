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
        return commentListViewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = commentListViewModel!.modelAt(indexPath.row)
        if comment.commentsResponseDtoList == nil {
            let cell = commentTableView.dequeueReusableCell(withIdentifier: "CommentResponseCell", for: indexPath) as! CommentResponseCell
            cell.configure(comment)
            return cell
        }else {
        let cell = commentTableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            cell.configure(comment)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}
