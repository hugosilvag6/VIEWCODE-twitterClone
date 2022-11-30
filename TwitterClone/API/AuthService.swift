//
//  AuthService.swift
//  TwitterClone
//
//  Created by Hugo Silva on 29/11/22.
//

import UIKit
import Firebase

struct AuthCredentials {
   let email: String
   let password: String
   let fullname: String
   let username: String
   let profileImage: UIImage
}

struct AuthService {
   static let shared = AuthService()
   
   func logUserIn(withEmail email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
      Auth.auth().signIn(withEmail: email, password: password, completion: completion)
   }
   
   func registerUser(credentials: AuthCredentials, completion: @escaping (Error?) -> Void) {
      let email = credentials.email
      let password = credentials.password
      let fullname = credentials.fullname
      let username = credentials.username
      
      guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
      let filename = UUID().uuidString
      let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
      storageRef.putData(imageData, metadata: nil) { meta, error in
         
         if let error {
            print(error.localizedDescription)
         }
         
         storageRef.downloadURL { url, error in
            guard let profileImageUrl = url?.absoluteString else { return }
            
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
               if let error {
                  print("DEBUG: error is \(error.localizedDescription)")
                  return
               }
               
               guard let uid = result?.user.uid else { return }

               let values = ["email": email, "username": username, "fullname": fullname, "profileImageUrl": profileImageUrl]
               
               REF_USERS.document(uid).setData(values, completion: completion)
            }
            
            
         }
      }
   }
}
