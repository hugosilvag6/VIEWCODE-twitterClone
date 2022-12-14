//
//  MainTabController.swift
//  TwitterClone
//
//  Created by Hugo Silva on 28/11/22.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
   
   // MARK: - Properties
   var user: User? {
      didSet {
         guard let nav = viewControllers?[0] as? UINavigationController else { return }
         guard let feed = nav.viewControllers.first as? FeedController else { return }
         feed.user = user
      }
   }
   
   let actionButton: UIButton = {
      let bt = UIButton(type: .system)
      bt.tintColor = .white
      bt.backgroundColor = .twitterBlue
      bt.setImage(UIImage(named: "new_tweet"), for: .normal)
      bt.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
      return bt
   }()
   
   // MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      authenticateUserAndConfigureUI()
   }
   
   // MARK: - API
   func fetchUser() {
      guard let uid = Auth.auth().currentUser?.uid else { return }
      UserService.shared.fetchUser(uid: uid) { user in
         self.user = user
      }
   }
   func authenticateUserAndConfigureUI() {
      if Auth.auth().currentUser == nil {
         DispatchQueue.main.async {
            let nav = UINavigationController(rootViewController: LoginController())
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
         }
      } else {
         configureViewControllers()
         configureUI()
         fetchUser()
      }
   }
   func logUserOut() {
      do {
         try Auth.auth().signOut()
         print("DEBUG: Logged user out...")
      } catch let error {
         print("DEBUG: failed to sign out with error: \(error.localizedDescription)")
      }
   }
   
   // MARK: - Selectors
   @objc func actionButtonTapped() {
      guard let user else { return }
      let controller = UploadTweetController(user: user)
      let nav = UINavigationController(rootViewController: controller)
      nav.modalPresentationStyle = .fullScreen
      present(nav, animated: true)
   }
   
   // MARK: - Helpers
   func configureUI() {
      view.addSubview(actionButton)
      actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
      actionButton.layer.cornerRadius = 56/2
   }
   func configureViewControllers() {
      let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
      let nav1 = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: feed)
      
      let explore = ExploreController()
      let nav2 = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: explore)
      
      let notifications = NotificationsController()
      let nav3 = templateNavigationController(image: UIImage(named: "like_unselected"), rootViewController: notifications)
      
      let conversations = ConversationsController()
      let nav4 = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: conversations)
      // o viewControllers ?? uma propriedade de UITabBarController
      viewControllers = [nav1, nav2, nav3, nav4]
   }
   func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
      let nav = UINavigationController(rootViewController: rootViewController)
      nav.tabBarItem.image = image
//      nav.navigationBar.isTranslucent = false
//      nav.navigationBar.backgroundColor = .systemPink
      return nav
   }
}
