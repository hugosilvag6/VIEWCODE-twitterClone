//
//  Constants.swift
//  TwitterClone
//
//  Created by Hugo Silva on 29/11/22.
//

import Firebase
import FirebaseStorage

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let DB_REF = Firestore.firestore()
let REF_USERS = DB_REF.collection("users")
let REF_TWEETS = DB_REF.collection("tweets")
