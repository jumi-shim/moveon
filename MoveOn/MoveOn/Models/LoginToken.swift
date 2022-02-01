//
//  LoginToken.swift
//  MoveOn
//
//  Created by 심주미 on 2022/01/12.
//


struct LoginInfo: Codable {
    let accessToken: String
    let refreshToken: String
    let userId:Int
}
