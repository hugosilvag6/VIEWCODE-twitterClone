//
//  RegistrationController.swift
//  TwitterClone
//
//  Created by Hugo Silva on 28/11/22.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
   
   // MARK: - Properties
   private let imagePicker = UIImagePickerController()
   private var profileImage: UIImage?
   
   private let plusPhotoButton: UIButton = {
      let bt = UIButton()
      bt.setImage(UIImage(named: "plus_photo")?.withRenderingMode(.alwaysTemplate), for: .normal)
      bt.tintColor = .white
      bt.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
      return bt
   }()
   private lazy var emailContainerView: UIView = {
      let view = Utilities().inputContainerView(withImage: "ic_mail_outline_white_2x-1", textfield: emailTextfield)
      return view
   }()
   private let emailTextfield: UITextField = {
      let tf = Utilities().textField(withPlaceholder: "Email")
      return tf
   }()
   private lazy var passwordContainerView: UIView = {
      let view = Utilities().inputContainerView(withImage: "ic_lock_outline_white_2x", textfield: passwordTextfield)
      return view
   }()
   private let passwordTextfield: UITextField = {
      let tf = Utilities().textField(withPlaceholder: "Password")
      tf.isSecureTextEntry = true
      return tf
   }()
   private lazy var fullNameContainerView: UIView = {
      let view = Utilities().inputContainerView(withImage: "ic_person_outline_white_2x", textfield: fullNameTextfield)
      return view
   }()
   private let fullNameTextfield: UITextField = {
      let tf = Utilities().textField(withPlaceholder: "Full Name")
      return tf
   }()
   private lazy var usernameContainerView: UIView = {
      let view = Utilities().inputContainerView(withImage: "ic_person_outline_white_2x", textfield: usernameTextfield)
      return view
   }()
   private let usernameTextfield: UITextField = {
      let tf = Utilities().textField(withPlaceholder: "Username")
      return tf
   }()
   private let alreadyHaveAccountButton: UIButton = {
      let bt = Utilities().attributedButton("Already have an account?", " Log In")
      bt.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
      return bt
   }()
   private let registrationButton: UIButton = {
      let bt = UIButton()
      bt.setTitle("Sign Up", for: .normal)
      bt.setTitleColor(.twitterBlue, for: .normal)
      bt.backgroundColor = .white
      bt.heightAnchor.constraint(equalToConstant: 50).isActive = true
      bt.layer.cornerRadius = 5
      bt.titleLabel?.font = .boldSystemFont(ofSize: 20)
      bt.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
      return bt
   }()
   // MARK: - Lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      configureUI()
   }
   // MARK: - Selectors
   @objc func handleShowLogin() {
      navigationController?.popViewController(animated: true)
   }
   @objc func handleAddProfilePhoto() {
      present(imagePicker, animated: true)
   }
   @objc func handleRegistration() {
      guard let email = emailTextfield.text else { return }
      guard let password = passwordTextfield.text else { return }
      guard let fullname = fullNameTextfield.text else { return }
      guard let username = usernameTextfield.text?.lowercased() else { return }
      guard let profileImage = profileImage else { return }
      
      let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
      
      AuthService.shared.registerUser(credentials: credentials) { error in
         if let error {
            print("DEBUG: error registering user: \(error.localizedDescription)")
         } else {
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
            guard let tab = window.rootViewController as? MainTabController else { return }
            tab.authenticateUserAndConfigureUI()
            self.dismiss(animated: true)
         }
      }

   }
   
   // MARK: - Helpers
   func configureUI() {
      view.backgroundColor = .twitterBlue
      
      imagePicker.delegate = self
      imagePicker.allowsEditing = true
      
      view.addSubview(plusPhotoButton)
      plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
      plusPhotoButton.setDimensions(width: 128, height: 128)
      
      let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullNameContainerView, usernameContainerView, registrationButton])
      stack.axis = .vertical
      stack.spacing = 20
      
      view.addSubview(stack)
      stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
      
      view.addSubview(alreadyHaveAccountButton)
      alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
   }
}

// MARK: - UIImagePickerControllerDelegate
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      guard let profileImage = info[.editedImage] as? UIImage else { return }
      self.profileImage = profileImage
      self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
      self.plusPhotoButton.layer.cornerRadius = 128/2
      self.plusPhotoButton.imageView?.contentMode = .scaleAspectFill
      self.plusPhotoButton.clipsToBounds = true
      self.plusPhotoButton.layer.borderColor = UIColor.white.cgColor
      self.plusPhotoButton.layer.borderWidth = 3
      dismiss(animated: true)
   }
}
