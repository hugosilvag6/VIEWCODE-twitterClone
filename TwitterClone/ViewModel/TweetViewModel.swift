//
//  TweetViewModel.swift
//  TwitterClone
//
//  Created by Hugo Silva on 30/11/22.
//

import UIKit

// no model criamos um init que "limpa"/"parseia" o model pra nós, tratando os dados de forma que as funções possam ficar mais limpas, já que tudo é tratado no model.
// a view model funciona de forma parecida, mas modela/limpa/parseia elementos essencialmente de view ou interface, trabalhando por exemplo computed properties que envolvem a criação de attributedStrings, ou executando funções que computam valores.
// A ideia da viewModel é "remover" o stress da view. No caso dessa, da view TweetCell
struct TweetViewModel {
   
   let tweet: Tweet
   let user: User
   
   var profileImageUrl: URL? {
      return user.profileImageUrl
   }
   
   var timestamp: String {
      let formatter = DateComponentsFormatter()
      formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
      formatter.maximumUnitCount = 1
      formatter.unitsStyle = .abbreviated
      let now = Date()
      return formatter.string(from: tweet.timestamp ?? now, to: now) ?? "2m"
   }
   
   var userInfoText: NSAttributedString {
      let title = NSMutableAttributedString(string: user.fullname, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
      title.append(NSAttributedString(string: " @\(user.username)", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
      title.append(NSAttributedString(string: " ∙ \(timestamp)", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
      return title
   }
   
   init(tweet: Tweet) {
      self.tweet = tweet
      self.user = tweet.user
   }
}
