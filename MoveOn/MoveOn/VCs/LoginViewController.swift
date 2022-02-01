//
//  ViewController.swift
//  MoveOn
//
//  Created by 심주미 on 2021/11/11.
//

import UIKit
import NMapsMap
import CoreLocation

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
        API().login(email: emailTextField.text!, password: passwordTextfield.text!) { result in
            if result {
                self.goToMap()
            }
        }
        //let keyChain = KeyChainManager()
        //print(keyChain.read(service: "moveOn", account: "accessToken"))
        //goToMap()
    }
    
}

