//
//  User.swift
//  TwitterClone
//
//  Created by Hugo Silva on 29/11/22.
//

import Foundation

struct User {
   let fullname: String
   let email: String
   let username: String
   var profileImageUrl: URL?
   let uid: String
   
   // a ideia por trás desse init é "delegar" ao model a responsabilidade de tratar/parsear os dados, "limpando" as funções e fetchs
   init(uid: String, dictionary: [String:AnyObject]) {
      self.uid = uid
      self.fullname = dictionary["fullname"] as? String ?? ""
      self.email = dictionary["email"] as? String ?? ""
      self.username = dictionary["username"] as? String ?? ""
      
      if let profileImageUrlString = dictionary["profileImageUrl"] as? String {
         guard let url = URL(string: profileImageUrlString) else { return }
         self.profileImageUrl = url
      }
   }
}
