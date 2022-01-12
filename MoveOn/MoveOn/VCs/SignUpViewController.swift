//
//  SignUpViewController.swift
//  MoveOn
//
//  Created by 심주미 on 2022/01/04.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var universityTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func signUp(_ sender: UIButton) {
        let url = "http://ec2-3-34-56-36.ap-northeast-2.compute.amazonaws.com:8080/api/auth/signup"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        let body = [
            "email":"abc@sju.ac.kr",
            "password":"abc",
            "name":"abc",
            "school":"세종대학교"
            ] as Dictionary
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: body, options: [])
        }catch{
            print("http body error")
        }
        
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success:
                print(response.value)
            case .failure(let error):
                print(error)
            }
        }
    }
    

    
}
