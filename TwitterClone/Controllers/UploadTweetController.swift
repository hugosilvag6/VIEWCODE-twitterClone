//
//  UploadTweetController.swift
//  TwitterClone
//
//  Created by Hugo Silva on 29/11/22.
//

import UIKit

class UploadTweetController: UIViewController {
   // MARK: - Properties
   private let user: User
   // o button normalmente precisa ser lazy var, pq quando é carregado ainda não tem a função pronta, e como é lazy, quando ele é chamado ela já tá pronta???????
   private lazy var actionButton: UIButton = {
      let bt = UIButton()
      bt.backgroundColor = .twitterBlue
      bt.setTitle("Tweet", for: .normal)
      bt.titleLabel?.textAlignment = .center
      bt.titleLabel?.font = .boldSystemFont(ofSize: 16)
      bt.setTitleColor(.white, for: .normal)
      bt.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
      bt.layer.cornerRadius = 32/2
      bt.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
      return bt
   }()
   private let profileImageView: UIImageView = {
      let iv = UIImageView()
      iv.contentMode = .scaleAspectFit
      iv.clipsToBounds = true
      iv.setDimensions(width: 48, height: 48)
      iv.layer.cornerRadius = 48/2
      iv.backgroundColor = .twitterBlue
      return iv
   }()
   private let captionTextView = CaptionTextView()
   // MARK: - Lifecycle
   init(user: User) {
      self.user = user
      super.init(nibName: nil, bundle: nil)
   }
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   override func viewDidLoad() {
      super.viewDidLoad()
      configureUI()
   }
   // MARK: - Selectors
   @objc func handleCancel() {
      dismiss(animated: true)
   }
   @objc func handleUploadTweet() {
      guard let caption = captionTextView.text else { return }
      TweetService.shared.uploadTweet(caption: caption) { error in
         if let error {
            print("DEBUG: Error: \(error.localizedDescription)")
         } else {
            print("DEBUG: Tweet successfully uploaded.")
            self.dismiss(animated: true)
         }
      }
   }
   // MARK: - API
   // MARK: - Helpers
   func configureUI() {
      view.backgroundColor = .white
      configureNavigationBar()
      
      let stack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
      stack.axis = .horizontal
      stack.spacing = 12
      
      view.addSubview(stack)
      stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
      UserService.shared.downloadUserImage(url: user.profileImageUrl) { image in
         self.profileImageView.image = image
      }
   }
   func configureNavigationBar() {
      //      navigationController?.navigationBar.barTintColor = .white
      //      navigationController?.navigationBar.isTranslucent = false
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
   }
}
