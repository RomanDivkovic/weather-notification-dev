//
//  ProfileViewController.swift
//  GardenizeNotification
//
//  Created by Roman Divkovic on 2022-01-28.
//

import UIKit
import Firebase
import DCToastView

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    var userEmail: String!
    let db = Firestore.firestore()
    
    @IBOutlet var emailUser: UILabel!
    @IBOutlet var lblStrong: UILabel!
    @IBAction func LogOut(_ sender: UIButton) {
        logOut()
    }
    @IBAction func changePswrd(_ sender: Any) {
        showAlertPswChange()
    }
    
    @IBAction func deletUser(_ sender: Any) {
        showAlertDelete()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        if let emailId = Auth.auth().currentUser?.email {
            userEmail = emailId
            self.emailUser.text = "Email: \(emailId)"
            print("show address", userEmail!)
            }
    }
        
    func showAlertPswChange() {
    
        let chooseAlert = UIAlertController(title: "Change password", message: "Do you wish to change password?", preferredStyle: .alert)
        chooseAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in }))
        chooseAlert.addAction(UIAlertAction(title: "Change", style: .default, handler: { action in

            let alert = UIAlertController(title: "Change password", message: "Change user password", preferredStyle: .alert)

            alert.addTextField { (textField) in
                textField.text = ""
            }

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0]
                Auth.auth().currentUser?.updatePassword(to: textField!.text!) { (error) in
                    ToastPresenter.shared.show(in: self.view, message: "Changed password", place: .down, timeOut: 2.5)
                    print("Changed password")
                }
            }))

           
            self.present(alert, animated: true, completion: nil)
            
        }))
        self.present(chooseAlert, animated: true, completion: nil)
    }
    
    func showAlertDelete() {
            let chooseAlert = UIAlertController(title: "Delete account", message: "Do you wish to delete account?", preferredStyle: .alert)
            chooseAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in }))
            chooseAlert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { action in
                self.deleteUser()
            }))
            self.present(chooseAlert, animated: true, completion: nil)
    }
    
    func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: "LoginController", sender: nil)
        } catch let signOutError as NSError{
            self.lblStrong.text = "Failed"
            ToastPresenter.shared.show(in: self.view, message:"Error, couldnt sign out", place: .down, timeOut: 2.5)
            print("Error", signOutError)
        }
    }
    
    // Delets first user data then deletes user from firebase
    func deleteUser(){
        db.collection("users").document(Auth.auth().currentUser!.uid).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
                ToastPresenter.shared.show(in: self.view, message:"Error removing document: \(err)", place: .down, timeOut: 2.5)
            } else {
                print("Document successfully removed!")
                Auth.auth().currentUser!.delete()
                self.performSegue(withIdentifier: "LoginController", sender: nil)
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
