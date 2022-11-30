//
//  TweetService.swift
//  TwitterClone
//
//  Created by Hugo Silva on 30/11/22.
//

import Firebase

struct TweetService {
   static let shared = TweetService()
   
   func uploadTweet(caption: String, completion: @escaping (Error?) -> Void) {
      guard let uid = Auth.auth().currentUser?.uid else { return }
      let values = ["uid": uid, "timestamp": Int(NSDate().timeIntervalSince1970), "likes": 0, "retweets": 0, "caption": caption] as [String:Any]
      REF_TWEETS.addDocument(data: values, completion: completion)
   }
   func fetchTweets(completion: @escaping ([Tweet]) -> Void) {
      var tweets = [Tweet]()
      REF_TWEETS.addSnapshotListener { snapshot, error in
         if let error {
            print("DEBUG: error in listener \(error.localizedDescription)")
         } else if let snapshot {
            snapshot.documentChanges.forEach { diff in
               guard let uid = diff.document.data()["uid"] as? String else { return }
               let tweetID = diff.document.documentID
               let values = diff.document.data()
               UserService.shared.fetchUser(uid: uid) { user in
                  let tweet = Tweet(user: user, tweetID: tweetID, dictionary: values)
                  tweets.append(tweet)
                  completion(tweets)
               }
            }
         }
      }
   }
}
