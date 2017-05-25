//
//  LoginViewController.swift
//  Task
//
//  Created by iGuest on 5/24/17.
//  Copyright © 2017 yyfan. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameF: UITextField!
    @IBOutlet weak var passwordF: UITextField!
    
    @IBAction func LoginBtnClick(_ sender: UIButton) {
        if let email = self.usernameF.text, let password = self.passwordF.text {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    self.showMessagePrompt(error.localizedDescription)
                    return
                }
                
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc: UIViewController = sb.instantiateViewController(withIdentifier: "home")
                
                self.present(vc, animated: true, completion: nil)
            }
        } else {
            self.showMessagePrompt("email/password can't be empty")
        }
    }
    
    func showMessagePrompt(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
