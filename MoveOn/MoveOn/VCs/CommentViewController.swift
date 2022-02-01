//
//  CommentViewController.swift
//  MoveOn
//
//  Created by 심주미 on 2022/01/25.
//

import Foundation
import UIKit

class CommentViewController: UIViewController {
    
    @IBOutlet weak var inputViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var commentTextView: UITextView!
    
    var commentListViewModel:CommentViewListModel?
    var commentPostId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTableView.delegate = self
        commentTableView.dataSource = self
        loadComment()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(noti: Notification) {
        let notiInfo = noti.userInfo!
        let keyboardFrame = notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let height = keyboardFrame.size.height - self.view.safeAreaInsets.bottom
        
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animationDuration) {
            self.inputViewBottomConstraint.constant = -height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(noti: Notification) {
        let notiInfo = noti.userInfo!
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animationDuration) {
            self.inputViewBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    func loadComment(){
        API().getComments(postId: commentPostId!){ [self] comments in
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
    
    @IBAction func sendComment(_ sender: UIButton) {
        if commentTextView.text != nil {
            API().postComment(comment: commentTextView.text, postId: commentPostId!) { response in
                if response {
                    self.commentTextView.text = ""
                    self.loadComment()
                }
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
