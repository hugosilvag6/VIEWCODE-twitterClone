//
//  FeedController.swift
//  TwitterClone
//
//  Created by Hugo Silva on 28/11/22.
//

import UIKit
import SwiftUI

class FeedController: UICollectionViewController {
   
   // MARK: - Properties
   var user: User? {
      didSet { configureLeftBarButton() }
   }
   private var tweets = [Tweet]() {
      didSet {
         self.collectionView.reloadData()
      }
   }
   
   // MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      configureUI()
      fetchTweets()
   }
   
   // MARK: - API
   func fetchTweets() {
      TweetService.shared.fetchTweets { tweets in
         print(tweets.count)
         self.tweets = tweets
      }
   }
   
   // MARK: - Helpers
   func configureUI() {
      collectionView.backgroundColor = .white
      collectionView.register(TweetCell.self, forCellWithReuseIdentifier: TweetCell.identifier)
      
      let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
      imageView.contentMode = .scaleAspectFit
      imageView.setDimensions(width: 44, height: 44)
      navigationItem.titleView = imageView
   }
   
   func configureLeftBarButton() {
      guard let user = user else { return }
      let profileImageView = UIImageView()
      profileImageView.setDimensions(width: 32, height: 32)
      profileImageView.layer.cornerRadius = 32/2
      profileImageView.clipsToBounds = true

      UserService.shared.downloadUserImage(url: user.profileImageUrl) { image in
         profileImageView.image = image
      }
      
      navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
   }
   
}

// MARK: - UICollectionViewDelegate/DataSource

extension FeedController {
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return tweets.count
   }
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TweetCell.identifier, for: indexPath) as? TweetCell
      cell?.tweet = tweets[indexPath.row]
      return cell ?? UICollectionViewCell()
   }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: view.frame.width, height: 120)
   }
}
