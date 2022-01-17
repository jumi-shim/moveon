//
//  PostModel.swift
//  MoveOn
//
//  Created by 심주미 on 2022/01/16.
//

import Foundation

struct PostModel: Codable{
    let userId:Int
    let nickname:String
    let profileUrl:String?
    let postId:Int
    let imgUrl:String?
    let content:String?
    let like:Bool
    let tags:[TagModel?]
}
