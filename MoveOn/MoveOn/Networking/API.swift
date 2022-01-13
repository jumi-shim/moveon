//
//  API.swift
//  MoveOn
//
//  Created by 심주미 on 2022/01/13.
//

import Alamofire

class API {
    let keyChainManager = KeyChainManager()
    func login(){
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
                print(loginToken.accessToken)
                
                self.keyChainManager.create(service: "login",account: "accessToken",value: loginToken.accessToken)
                print(self.keyChainManager.read(service: "login", account: "accessToken"),"!!")
            case .failure(let error):
                print(error)
            }
        }
    }
}
