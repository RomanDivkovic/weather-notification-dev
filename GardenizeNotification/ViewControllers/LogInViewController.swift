//
//  LogInViewController.swift
//  GardenizeNotification
//
//  Created by Roman Divkovic on 2022-01-28.
//

import UIKit
import Firebase


class LogInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet weak var email: UITextField!
    
    @IBAction func pswDone(_ sender: UITextField) {
    }
    @IBAction func done(_ sender: Any) {
    }
    @IBOutlet weak var password: UITextField!
    @IBAction func LogIn(_ sender: UIButton) {
        didUserSignIn()
    }
    @IBAction func forgot(_ sender: Any) {
        performSegue(withIdentifier: "ForgotViewController", sender: nil)
    }
    @IBAction func register(_ sender: Any) {
        performSegue(withIdentifier: "RegisterViewController", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func isValidPasswordString(pwdStr:String) -> Bool {

        let pwdRegEx = "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{6,15}"

        let pwdTest = NSPredicate(format:"SELF MATCHES %@", pwdRegEx)
        return pwdTest.evaluate(with: pwdStr)
    }

    func didUserSignIn() {
        let txtEmail = email.text!
        let txtPassword = password.text!
       
        Auth.auth().signIn(withEmail: txtEmail, password: txtPassword) { [weak self] authResult, error in
            if let x = error {
                  let err = x as NSError
                  switch err.code {
                  case AuthErrorCode.wrongPassword.rawValue:
                     self!.lblStatus.text = "Wrong password"
                     print("wrong password")
                  case AuthErrorCode.invalidEmail.rawValue:
                     self!.lblStatus.text = "Invalid email"
                     print("invalid email")
                  case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                      self!.lblStatus.text = "accountExistsWithDifferentCredential"
                     print("accountExistsWithDifferentCredential")
                  case AuthErrorCode.emailAlreadyInUse.rawValue: //<- Your Error
                      self!.lblStatus.text = "Email is alreay in use"
                     print("email is alreay in use")
                  default:
                      self!.lblStatus.text = "Unknown error: \(err.localizedDescription)"
                     print("unknown error: \(err.localizedDescription)")
                  }
                
               } else {
                   //continue to app
                   self!.lblStatus.text = "Sign In, ok!!"
                   self!.performSegue(withIdentifier: "fromLogIn", sender: nil)

               }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
