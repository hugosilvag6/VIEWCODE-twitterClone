//
//  UserService.swift
//  TwitterClone
//
//  Created by Hugo Silva on 29/11/22.
//

import UIKit
import Firebase

struct UserService {
   static let shared = UserService()
   
   func fetchUser(uid: String, completion: @escaping (User) -> Void) {
      REF_USERS.document(uid).getDocument { snapshot, error in
         if let error {
            print("DEBUG: failed to fetch user... \(error.localizedDescription)")
         } else if let snapshot {
            guard let dictionary = snapshot.data() as? [String:AnyObject] else { return }
            
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
         }
      }
   }
   func downloadUserImage(url: URL?, completion: @escaping (UIImage) -> Void) {
      guard let url else { return }
      DispatchQueue.global().async { 
         if let data = try? Data(contentsOf: url) {
             if let image = UIImage(data: data) {
                 DispatchQueue.main.async {
                     completion(image)
                 }
             }
         }
     }
   }
}
