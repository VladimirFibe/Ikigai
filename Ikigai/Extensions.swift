//
//  Extensions.swift
//  Uber
//
//  Created by Vladimir Fibe on 01.01.2022.
//

import UIKit

extension UIColor {
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
  }
  
  static let backgroundColor = UIColor.rgb(red: 25, green: 25, blue: 25)
  static let mainBlueTint = UIColor.rgb(red: 17, green: 154, blue: 237)
}
extension UIView {
  
  func inputContainerView(image: UIImage,
                          heght: CGFloat = 50,
                          textField: UITextField? = nil,
                          segmentedControl: UISegmentedControl? = nil) -> UIView {
    let view = UIView()
    
    let imageView = UIImageView()
    imageView.image = image
    imageView.alpha = 0.87
    view.addSubview(imageView)
    
    if let textField = textField {
      imageView.centerY(inView: view)
      imageView.anchor(left: view.leftAnchor, paddingLeft: 8, width: 24, height: 24)
      view.addSubview(textField)
      textField.centerY(inView: view)
      textField.anchor(left: imageView.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingButton: 8)
    }
    
    if let segmentedControl = segmentedControl {
      imageView.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: -8, paddingLeft: 8, width: 24, height: 24)
      view.addSubview(segmentedControl)
      segmentedControl.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 8, paddingRight: 8)
      segmentedControl.centerY(inView: view, constant: 8)
    }
    let separatorView = UIView()
    separatorView.backgroundColor = .lightGray
    view.addSubview(separatorView)
    separatorView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, height: 0.75)
    
    view.heightAnchor.constraint(equalToConstant: heght).isActive = true
    return view
  }
  func anchor(top: NSLayoutYAxisAnchor? = nil,
              left: NSLayoutXAxisAnchor? = nil,
              bottom: NSLayoutYAxisAnchor? = nil,
              right: NSLayoutXAxisAnchor? = nil,
              paddingTop: CGFloat = 0,
              paddingLeft: CGFloat = 0,
              paddingButton: CGFloat = 0,
              paddingRight: CGFloat = 0,
              width: CGFloat? = nil,
              height: CGFloat? = nil) {
    
    translatesAutoresizingMaskIntoConstraints = false
    
    if let top = top {
      topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
    }
    if let left = left {
      leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
    }
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: -paddingButton).isActive = true
    }
    if let right = right {
      rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
    }
    if let width = width {
      widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    if let height = height {
      heightAnchor.constraint(equalToConstant: height).isActive = true
    }
  }
  
  func centerX(inView view: UIView, constant: CGFloat = 0) {
    centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
  }
  
  func centerY(inView view: UIView,
               left: NSLayoutXAxisAnchor? = nil,
               paddingLeft: CGFloat = 0,
               constant: CGFloat = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    if let left = left {
      leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
    }
  }
  
  func setDimensions(width: CGFloat, height: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(equalToConstant: width).isActive = true
    heightAnchor.constraint(equalToConstant: height).isActive = true
  }
  
  func addShadow() {
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.55
    layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    layer.masksToBounds = false
  }
}

extension UITextField {
  func textField(withPlaceholder placeholder: String, isSecureTextEntry: Bool = false) -> UITextField {
    let tf = UITextField()
    tf.borderStyle = .none
    tf.font = UIFont.systemFont(ofSize: 16)
    tf.textColor = .white
    tf.keyboardAppearance = .dark
    tf.isSecureTextEntry = isSecureTextEntry
    tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    return tf
  }
}
