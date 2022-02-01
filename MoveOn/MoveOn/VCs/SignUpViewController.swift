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
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userEmail:String = ""
    var userUnivName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func signUp(_ sender: UIButton) {
    
        if nameTextField.text != nil && passwordTextField.text != nil {
            API().signUp(email: userEmail, password: passwordTextField.text!, name: nameTextField.text!, univ: userUnivName) { response in
                
                if response != nil {
                    guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") else {
                        return
                    }
                    
                    loginVC.modalPresentationStyle = .fullScreen
                    loginVC.modalTransitionStyle = .crossDissolve
                    self.present(loginVC, animated: true, completion: nil)
                }
                
            }
        }
        
    }
        
    

    
}
