//
//  NotificationsController.swift
//  TwitterClone
//
//  Created by Hugo Silva on 28/11/22.
//

import UIKit

class NotificationsController: UIViewController {
   
   // MARK: - Properties
   
   // MARK: - Lifecycle
   // MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      configureUI()
   }
   
   // MARK: - Helpers
   func configureUI() {
      view.backgroundColor = .white
      
      navigationItem.title = "Notifications"
   }
   
}

