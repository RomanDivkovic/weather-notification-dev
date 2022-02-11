//
//  ProfileViewController.swift
//  GardenizeNotification
//
//  Created by Roman Divkovic on 2022-01-28.
//

import UIKit
import Firebase

/*
 try
 installing this in pod
 pod 'DCToastView'
 
 import DCToastView

 And use it

 ToastPresenter.shared.show(in: self.view, message: "This is a toast")
 */
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
                let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                Auth.auth().currentUser?.updatePassword(to: textField!.text!) { (error) in
                    
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
        // LOG OUT
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: "LoginController", sender: nil)
        } catch let signOutError as NSError{
            self.lblStrong.text = "Failed"
            print("Error", signOutError)
        }
    }
    
    // Need to fix the delete so all of user data deletes before user deletse from app
    func deleteUser(){
//        Auth.auth().currentUser.
        Auth.auth().currentUser!.delete()
        performSegue(withIdentifier: "LoginController", sender: nil)
//        let user = Auth.auth().currentUser
//        var credential: AuthCredential
//
//        // Prompt the user to re-provide their sign-in credentials
//
//        user?.reauthenticate(with: credential) { error in
//          if let error = error {
//            // An error happened.
//              self.lblStrong.text = "Failed to reauthenticate user"
//              print("Error!!")
//          } else {
//            // User re-authenticated.
//              user?.delete()
//          }
//        }
        
        /*
         
         db.collection("users").document(self.user.uid).collection("sachets").getDocuments() { (QuerySnapshot, err) in
             if let err = err{
                 print("Erreur de lecture : \(err)")
             } else {
                 for document in QuerySnapshot!.documents {
                     db.collection("users").document(self.user.uid).collection("sachets").document(document.documentID).delete(){ err in
                         if let err = err {
                             print("   🔴 Problème de suppression des documents \(err)")
                         } else {
                             print("   🔵 Documents supprimés")
                         }
                     }
                 }
             }

             self.user?.delete { error in
                 if let error = error {
                     print("   🔴 Problème de suppression du compte Utilisateur \(error)")
                 } else {
                     print("   🔵 Utilisateur supprimé")
                 }
             }
         }
         
         */
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
