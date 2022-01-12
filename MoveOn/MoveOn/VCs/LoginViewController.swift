//
//  ViewController.swift
//  MoveOn
//
//  Created by 심주미 on 2021/11/11.
//

import UIKit
import NMapsMap
import CoreLocation
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    func goToMap() {
        guard let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "TapBarController") else {
            return
        }
        
        mapVC.modalPresentationStyle = .fullScreen
        mapVC.modalTransitionStyle = .crossDissolve
        self.present(mapVC, animated: true, completion: nil)
    }
    @IBAction func login(_ sender: UIButton) {
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
                print(loginToken)
            case .failure(let error):
                print(error)
            }
        }
    }
}

