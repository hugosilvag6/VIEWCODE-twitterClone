//
//  TweetCell.swift
//  TwitterClone
//
//  Created by Hugo Silva on 30/11/22.
//

import UIKit

class TweetCell: UICollectionViewCell {
   
   static let identifier = "TweetCell"
   
   // MARK: - Properties
   var tweet: Tweet? {
      didSet {
         configure()
      }
   }
   private let profileImageView: UIImageView = {
      let iv = UIImageView()
      iv.contentMode = .scaleAspectFit
      iv.clipsToBounds = true
      iv.setDimensions(width: 48, height: 48)
      iv.layer.cornerRadius = 48/2
      iv.backgroundColor = .twitterBlue
      return iv
   }()
   private let captionLabel: UILabel = {
      let lb = UILabel()
      lb.font = .systemFont(ofSize: 14)
      lb.numberOfLines = 0
      lb.text = "Test caption"
      return lb
   }()
   private lazy var commentButton: UIButton = {
      let bt = UIButton()
      bt.setImage(UIImage(named: "comment"), for: .normal)
      bt.tintColor = .darkGray
      bt.setDimensions(width: 20, height: 20)
      bt.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
      return bt
   }()
   private lazy var retweetButton: UIButton = {
      let bt = UIButton()
      bt.setImage(UIImage(named: "retweet"), for: .normal)
      bt.tintColor = .darkGray
      bt.setDimensions(width: 20, height: 20)
      bt.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
      return bt
   }()
   private lazy var likeButton: UIButton = {
      let bt = UIButton()
      bt.setImage(UIImage(named: "like"), for: .normal)
      bt.tintColor = .darkGray
      bt.setDimensions(width: 20, height: 20)
      bt.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
      return bt
   }()
   private lazy var shareButton: UIButton = {
      let bt = UIButton()
      bt.setImage(UIImage(named: "share"), for: .normal)
      bt.tintColor = .darkGray
      bt.setDimensions(width: 20, height: 20)
      bt.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
      return bt
   }()
   private let infoLabel = UILabel()
   // MARK: - Lifecycle
   override init(frame: CGRect) {
      super.init(frame: frame)
      backgroundColor = .white
      
      addSubview(profileImageView)
      profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
      
      let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
      stack.axis = .vertical
      stack.distribution = .fillProportionally
      stack.spacing = 4
      addSubview(stack)
      stack.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)
      
      infoLabel.font = .systemFont(ofSize: 14)
      infoLabel.text = "Eddie Brock @venom"
      
      let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
      actionStack.axis = .horizontal
      actionStack.spacing = 72
      addSubview(actionStack)
      actionStack.centerX(inView: self)
      actionStack.anchor(bottom: bottomAnchor, paddingBottom: 8)
      
      let underlineView = UIView()
      underlineView.backgroundColor = .systemGroupedBackground
      addSubview(underlineView)
      underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
   }
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   // MARK: - Selectors
   @objc func handleCommentTapped(){}
   @objc func handleRetweetTapped(){}
   @objc func handleLikeTapped(){}
   @objc func handleShareTapped(){}
   // MARK: - Helpers
   func configure() {
      guard let tweet else { return }
      let viewModel = TweetViewModel(tweet: tweet)
      captionLabel.text = tweet.caption
      UserService.shared.downloadUserImage(url: viewModel.profileImageUrl) { image in
         self.profileImageView.image = image
      }
      infoLabel.attributedText = viewModel.userInfoText
   }
   
   
   
}
