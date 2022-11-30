//
//  CaptionTextView.swift
//  TwitterClone
//
//  Created by Hugo Silva on 30/11/22.
//

import UIKit

class CaptionTextView: UITextView {
   
   // MARK: - Properties
   let placeholderLabel: UILabel = {
      let lb = UILabel()
      lb.font = .systemFont(ofSize: 16)
      lb.textColor = .darkGray
      lb.text = "What's happening?"
      return lb
   }()
   
   // MARK: - Lifecycle
   override init(frame: CGRect, textContainer: NSTextContainer?) {
      super.init(frame: frame, textContainer: textContainer)
      
      backgroundColor = .white
      font = .systemFont(ofSize: 16)
      isScrollEnabled = false
      heightAnchor.constraint(equalToConstant: 300).isActive = true
      
      addSubview(placeholderLabel)
      placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 4)
      
      NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
   }
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   // MARK: - Selectors
   @objc func handleTextInputChange() {
      placeholderLabel.isHidden = !text.isEmpty
   }
}
