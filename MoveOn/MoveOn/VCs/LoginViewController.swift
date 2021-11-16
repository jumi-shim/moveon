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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    @IBAction func goToMap(_ sender: UIButton) {
        guard let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "TapBarController") else {
            return
        }
        
        mapVC.modalPresentationStyle = .fullScreen
        mapVC.modalTransitionStyle = .crossDissolve
        self.present(mapVC, animated: true, completion: nil)
    }
}

