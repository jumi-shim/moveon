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
    
    func numberOfRows() -> Int {
        var responseCount = 0
        comments.forEach{ responseCount += $0.commentsResponseDtoList?.count ?? 0 }
        return comments.count + responseCount
    }
    
    func modelAt(_ index: Int) -> CommentsModel {
        var cnt = 0
        var targetComment: CommentsModel!
        for comment in comments {
            print(comment, cnt)
            if cnt == index {
                targetComment = comment
            }
            cnt += 1
            if let recomments = comment.commentsResponseDtoList{
                for recomment in recomments {
                    print(recomments, cnt)
                    if cnt == index {
                        return recomment!
                        
                    }
                    cnt += 1
                }
            }
        }
        return targetComment
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
