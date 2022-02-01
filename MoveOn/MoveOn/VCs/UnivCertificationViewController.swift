//
//  UnivCertificationViewController.swift
//  MoveOn
//
//  Created by 심주미 on 2022/02/01.
//

import Foundation
import UIKit

class UnivCertificationViewController: UIViewController {
    @IBOutlet weak var univNameTextField: UITextField!
    @IBOutlet weak var univEmailTextField: UITextField!
    @IBOutlet weak var certificationCodeTextField: UITextField!
    
    var certificationCode:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func sendCertificationCode(_ sender: UIButton) {
        if univNameTextField.text == nil || univEmailTextField.text == nil {
            return
        }
        
        API().getUnivCertificationCode(email: univEmailTextField.text!, univName: univNameTextField.text!) { code in
            guard let code = code else {
                return
            }
            self.certificationCode = code
            
            let alert = UIAlertController(title: "인증코드 발송 완료", message: "학교 메일을 통해 보내드린 인증코드를 입력해주세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
        }
        
    }
    
    @IBAction func goNextStep(_ sender: UIButton) {
        if certificationCode == certificationCodeTextField.text {
            let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            
            signUpVC.userUnivName = univNameTextField.text!
            signUpVC.userEmail = univEmailTextField.text!
            
            self.present(signUpVC, animated: true, completion: nil)
            
        }
    }
    
    
}
