//
//  CommentListViewModel.swift
//  MoveOn
//
//  Created by 심주미 on 2022/01/25.
//

import Foundation

class CommentViewListModel {
    //private var commentViewModels = [CommentViewModel]()
    let comments:[CommentsModel]
    
    init(comments: [CommentsModel]){
        self.comments = comments
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return comments.count
    }
    
    func modelAt(_ index: Int) -> CommentsModel {
        return comments[index]
    }
}

class CommentViewModel {
    let commentModel: CommentModel
    init(commentModel: CommentModel) {
        self.commentModel = commentModel
    }
    var nickname: String {
        return commentModel.nickname
    }
    var content: String {
        return commentModel.content
    }
}
