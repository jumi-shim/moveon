//
//  PostModel.swift
//  MoveOn
//
//  Created by 심주미 on 2022/01/14.
//

import Foundation

//import RxDataSources

struct TagPost:Codable {
    let tagId:Int
    let tagContent:String
    let postId:Int
    let userId:Int
    let userNickname:String
    let postsContent:String?
    let profileUrl:URL?
}


struct TagModel: Codable {
    let createdDate:String
    let modifiedDate:String
    let id:Int
    let content:String
}
