//
//  ConversationsController.swift
//  TwitterClone
//
//  Created by Hugo Silva on 28/11/22.
//

import UIKit

class ConversationsController: UIViewController {
   
   // MARK: - Properties
   
   // MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      configureUI()
   }
   
   // MARK: - Helpers
   func configureUI() {
      view.backgroundColor = .white
      
      navigationItem.title = "Messages"
   }
   
}
