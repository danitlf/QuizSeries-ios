//
//  ViewController.swift
//  Quiz Series
//
//  Created by daniel tavares de lima freitas on 29/12/17.
//  Copyright © 2017 daniel tavares de lima freitas. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit


class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginFacebookBtn = FBSDKLoginButton()
        loginFacebookBtn.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        view.addSubview(loginFacebookBtn)
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

