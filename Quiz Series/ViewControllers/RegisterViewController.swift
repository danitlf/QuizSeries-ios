//
//  RegisterViewController.swift
//  Quiz Series
//
//  Created by daniel tavares de lima freitas on 30/12/17.
//  Copyright © 2017 daniel tavares de lima freitas. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var labelWarning: UILabel!
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var registerBox: UIView!
    let seriesApi = SeriesAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerBox.layer.cornerRadius = 10
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerBox.layer.cornerRadius = 10
        labelWarning.isHidden = true
    }
    

    @IBAction func sendNickname(_ sender: UIButton) {
        if let nickname: String = nicknameField.text {
            self.seriesApi.registerNickname(nickname: nickname){
                if self.seriesApi.createdUser.userID != nil &&
                    self.seriesApi.createdUser.userName != nil {
                    
                    self.seriesApi.createdUser.saveUserOnDevice()
                   
                    self.performSegue(withIdentifier: "ListSeriesSegue" , sender: nil)
                    
                }
                else{
                    //user already exists
                    self.labelWarning.text = "Usuário já existe"
                    self.labelWarning.isHidden = false
                    
                    
                }
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
