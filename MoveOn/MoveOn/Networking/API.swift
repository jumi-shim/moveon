//
//  API.swift
//  MoveOn
//
//  Created by 심주미 on 2022/01/13.
//

import Alamofire

class API {
    let keyChainManager = KeyChainManager()
    func login(completion: @escaping (Bool)->Void){
        let url = "http://ec2-3-34-56-36.ap-northeast-2.compute.amazonaws.com:8080/api/auth/login"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        let parameter = ["email": "abc@sju.ac.kr",
         "password": "abc"] as Dictionary
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: parameter, options: [])
        }catch{
            print("http body error")
        }
        
        AF.request(request).responseDecodable { (response:AFDataResponse<LoginToken>) in
            switch response.result {
            case .success(let loginToken):
                if self.keyChainManager.saveLoingToken(accessToken: loginToken.accessToken, refreshToken: loginToken.refreshToken) {
                    
                    print(loginToken)
                    completion(true)
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
        completion(false)
    }
    
    func loadPost(completion: @escaping ([PostModel]?)->Void) {
        let headers: HTTPHeaders = [
            .authorization(bearerToken: keyChainManager.read(service: "moveOn", account: "accessToken")!)]
        print(keyChainManager.read(service: "moveOn", account: "accessToken")!)
        AF.request("http://ec2-3-34-56-36.ap-northeast-2.compute.amazonaws.com:8080/api/v1/posts/select?department_id=2&size=10", headers: headers).responseDecodable(completionHandler: { (response:AFDataResponse<[PostModel]>) in
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
}
