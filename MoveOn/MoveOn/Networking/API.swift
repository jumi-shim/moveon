//
//  API.swift
//  MoveOn
//
//  Created by 심주미 on 2022/01/13.
//

import Alamofire

class API {
    let keyChainManager = KeyChainManager()
    func login(email:String, password:String, completion: @escaping (Bool)->Void){
        
        let parameter = ["email": email,
         "password": password]
      
        AF.request("http://ec2-3-34-56-36.ap-northeast-2.compute.amazonaws.com:8080/api/auth/login", method: .post, parameters:  parameter, encoding: JSONEncoding.default ).responseDecodable { (response:AFDataResponse<LoginInfo>) in
            switch response.result {
            case .success(let loginInfo):
                if self.keyChainManager.saveLoginToken(accessToken: loginInfo.accessToken, refreshToken: loginInfo.refreshToken) {
                    UserDefaults.standard.set(loginInfo.userId, forKey: "userId")
                    
                    print(loginInfo)
                    completion(true)
                    return
                }
            case .failure(let error):
                completion(false)
                print(error)
            }
        }
    }
    
    func getUnivCertificationCode(email:String, univName: String, completion: @escaping (String?) -> Void) {
        let parameter = ["address":email,
                         "school":univName]
        AF.request("http://ec2-3-34-56-36.ap-northeast-2.compute.amazonaws.com:8080/api/auth/email", method: .post, parameters: parameter, encoding: JSONEncoding.default).responseString { response in
            switch response.result {
            case .success :
                print(response.value)
                completion(response.value)
                return
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
    func signUp(email:String, password:String, name:String, univ:String, completion: @escaping (String?)->Void){
        let parameter = [
            "email":email,
            "password":password,
            "name":name,
            "school":univ
            ]
        
        AF.request("http://ec2-3-34-56-36.ap-northeast-2.compute.amazonaws.com:8080/api/auth/signup", method: .post, parameters: parameter, encoding: JSONEncoding.default ).responseString { (response) in
            switch response.result {
            case .success:
                print(response.value)
                completion(response.value)
                return
            case .failure(let error):
                print(error)
                completion(nil)
                return
            }
        }
    
    }
    
    func loadPost(completion: @escaping ([PostModel]?)->Void) {
        let headers: HTTPHeaders = [
            .authorization(bearerToken: keyChainManager.read(service: "moveOn", account: "accessToken")!)]
        print(keyChainManager.read(service: "moveOn", account: "accessToken")!)
        AF.request("http://ec2-3-34-56-36.ap-northeast-2.compute.amazonaws.com:8080/api/v1/posts/select?department-id=2&size=2&user-id=10", headers: headers).responseDecodable(completionHandler: { (response:AFDataResponse<[PostModel]>) in
            switch response.result {
            case .success:
                completion(response.value)
                return
            case .failure(let error):
                print(error)
                completion(nil)
            }
        })
    }
    
    func getComments(completion: @escaping ([CommentsModel]?) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: keyChainManager.read(service: "moveOn", account: "accessToken")!)]
        
        AF.request("http://ec2-3-34-56-36.ap-northeast-2.compute.amazonaws.com:8080/api/v1/comments/select?post-id=6", headers: headers).responseDecodable { (response:AFDataResponse<[CommentsModel]>) in
            switch response.result {
            case .success:
                completion(response.value)
                return
            case .failure(let error):
                completion(nil)
                print(error)
                
            }
        }
    }
    
    func postComment(comment:String, completion: @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: keyChainManager.read(service: "moveOn", account: "accessToken")!)]
        let parameter = [
            "schoolId":"1",
            "departmentId":"2",
            "userId":"3",
            "postId":"2",
            "nickname":"나는야숨",
            "content": comment,
            "classNum":"0",
            "groupId":"2"
        ]
        AF.request("http://ec2-3-34-56-36.ap-northeast-2.compute.amazonaws.com:8080/api/v1/comments/save", method: .post, parameters: parameter, headers: headers
        ).response { response in
            switch response.result {
            case .success :
                completion(true)
                return
            case .failure(let error) :
                print(error)
                completion(false)
                return
            }
        }
    }
    
    
}
