//
//  CommentModel.swift
//  MoveOn
//
//  Created by 심주미 on 2022/01/25.
//

import Foundation

struct CommentsModel:Codable {
    var userId: Int
    var nickname: String
    var content: String
    var groupId: Int
    var commentsResponseDtoList: [CommentsModel?]?
}
/*
struct CommentResponseModel: Codable {
    var userId: Int
    var nickname: String
    var content: String
    var groupId: Int
}*/


enum ComentType: String, Codable {
    case originComent = "0"
    case comentOfComent = "1"
}

struct CommentModel:Codable {
    var schoolId:String
    var departmentId:String
    var userId:String
    var postId:String
    var nickname:String
    var content:String
    var classNum:ComentType
    var groupId:String?
}

