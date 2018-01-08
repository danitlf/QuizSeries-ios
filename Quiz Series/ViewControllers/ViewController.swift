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
import FirebaseDatabase


class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var imagePerfil: UIImageView!
    let fapiFirebaseAPI = FirebaseAPI()
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        else{
            //login succes
            //getFBUserData()
            loginFirebase()
        }
    }

    func loginFirebase() {
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            else{
                self.fapiFirebaseAPI.initialCreateFIrebaseUser()
                self.performSegue(withIdentifier: "loginToListSeriesSegue", sender: nil)

            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logout")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("logout no firebase")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginFacebookBtn = FBSDKLoginButton()
        loginFacebookBtn.frame = CGRect(x: 16, y: view.frame.height - 100, width: view.frame.width - 32, height: 50)
        loginFacebookBtn.delegate = self
        view.addSubview(loginFacebookBtn)
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

