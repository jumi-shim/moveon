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
                    UserDefaults.standard.set(String(loginInfo.userId), forKey: "userId")
                    UserDefaults.standard.set(String(loginInfo.schoolId), forKey: "univId")
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
        let userId = UserDefaults.standard.string(forKey: "userId")!
        let headers: HTTPHeaders = [
            .authorization(bearerToken: keyChainManager.read(service: "moveOn", account: "accessToken")!)]
        print(keyChainManager.read(service: "moveOn", account: "accessToken")!)
        AF.request("http://ec2-3-34-56-36.ap-northeast-2.compute.amazonaws.com:8080/api/v1/posts/select?department-id=2&size=10&user-id=" + userId, headers: headers).responseDecodable(completionHandler: { (response:AFDataResponse<[PostModel]>) in
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
    
    func getComments(postId:String, completion: @escaping ([CommentsModel]?) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: keyChainManager.read(service: "moveOn", account: "accessToken")!)]
        
        AF.request("http://ec2-3-34-56-36.ap-northeast-2.compute.amazonaws.com:8080/api/v1/comments/select?post-id=" + postId, headers: headers).responseDecodable { (response:AFDataResponse<[CommentsModel]>) in
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
    
    func postComment(comment:String, postId:String, completion: @escaping (Bool) -> Void) {
        let userId = UserDefaults.standard.string(forKey: "userId")!
        let univId = UserDefaults.standard.string(forKey: "univId")!
        let nickname = UserDefaults.standard.string(forKey: "nickname") ?? "익명"
        let headers: HTTPHeaders = [.authorization(bearerToken: keyChainManager.read(service: "moveOn", account: "accessToken")!)]
        
        let parameter = [
            "schoolId":univId,
            "departmentId":"2",
            "userId":userId,
            "postId":postId,
            "nickname":nickname,
            "content": comment,
            "classNum":"0",
            "groupId":""
        ]
        AF.request("http://ec2-3-34-56-36.ap-northeast-2.compute.amazonaws.com:8080/api/v1/comments/save", method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headers).responseString { response in
            switch response.result {
            case .success :
                print(response.value,"!!!!")
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
