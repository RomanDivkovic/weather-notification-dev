//
//  DetailViewController.swift
//  GardenizeNotification
//
//  Created by Roman Divkovic on 2022-01-28.
//

import UIKit
import Firebase


class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBAction func email(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func password(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func Register(_ sender: UIButton) {
        didUserRegister()
    }
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func didUserRegister() {
        let txtEmail = email.text!
        let txtPassword = password.text!
        if (isValidPasswordString(pwdStr: txtPassword) == true) {
            Auth.auth().createUser(withEmail: txtEmail, password: txtPassword) { authResult, error in
                if let x = error {
                      let err = x as NSError
                      switch err.code {
                      case AuthErrorCode.wrongPassword.rawValue:
                          self.lblStatus.text = "Wrong password"
                         print("wrong password")
                      case AuthErrorCode.invalidEmail.rawValue:
                          self.lblStatus.text = "Invalid email"
                         print("invalid email")
                      case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                          self.lblStatus.text = "accountExistsWithDifferentCredential"
                         print("accountExistsWithDifferentCredential")
                      case AuthErrorCode.emailAlreadyInUse.rawValue:
                          self.lblStatus.text = "Email is alreay in use"
                         print("email is alreay in use")
                      default:
                         print("unknown error: \(err.localizedDescription)")
                      }
                   } else {
                       //continue to app
                       self.performSegue(withIdentifier: "fromRegister", sender: nil)
                   }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Password needs between 6-15, digets or letters and one number atleast", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func isValidPasswordString(pwdStr:String) -> Bool {
        let pwdRegEx = "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{6,15}"

        let pwdTest = NSPredicate(format:"SELF MATCHES %@", pwdRegEx)
        return pwdTest.evaluate(with: pwdStr)
    }
}
