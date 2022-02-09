//
//  HomeViewController.swift
//  GardenizeNotification
//
//  Created by Roman Divkovic on 2022-01-28.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    let db = Firestore.firestore()

    @IBAction func done(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func Done(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBOutlet var lat: UITextField!
    @IBOutlet var long: UITextField!
    @IBAction func testBtn(_ sender: UIButton) {
//        Messaging.messaging().subscribe(toTopic: "weather") { error in  print("Subscribed to weather topic")}
    }
        /*
     db.collection("users").document("LA").setData([
         "country": "Sweden",
         "latitude": lat!,
         "longitude":long!,

     ]) { err in
         if let err = err {
             print("Error writing document: \(err)")
         } else {
             print("Document successfully written!")
         }
     }
     */
    @IBAction func AddData(_ sender: Any) {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { [self] idToken, error in
          if let error = error {
            // Handle error
              print("Error Message", error)
            return;
          }
            
          // Send token to your backend via HTTPS
          // ...
            let x = "x"
            let lat1 = lat.text! + x
            let weatherTopic = lat1 + long.text!
            db.collection("users").document(Auth.auth().currentUser!.uid).setData([
                "country": "Sweden",
                "latitude": Int(lat.text!)!,
                "longitude": Int(long.text!)!,
                "token": idToken!,
                "weatherTopic": "Sweden"+weatherTopic
                
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return false
//    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//            self.view.endEditing(true)
//            return false
//        }
    
}
