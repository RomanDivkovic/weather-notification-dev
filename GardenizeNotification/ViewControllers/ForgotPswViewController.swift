//
//  ForgotPswViewController.swift
//  GardenizeNotification
//
//  Created by Roman Divkovic on 2022-02-09.
//

import UIKit
import Firebase

class ForgotPswViewController: UIViewController {
    @IBOutlet var email: UITextField!
    @IBAction func done(_ sender: Any) {
    }
    
    @IBAction func doneButton(_ sender: Any) {
        callFIRPasswordReset()
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func callFIRPasswordReset(){
        //show loader
        
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: email.text!, completion: { (error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: { action in }))
                self.present(alert, animated: true, completion: nil)
            }
            let alert = UIAlertController(title: "Succes", message: "An email was sent to adress to reset password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: { action in }))
            
            self.present(alert, animated: true, completion: nil)
        })
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
