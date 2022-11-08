//
//  AuthButton.swift
//  Taxi_clone
//
//  Created by Timophey Ivanenko on 02.11.2022.
//

import UIKit

class AuthButton: UIButton {
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .mainBlueTint
    layer.cornerRadius = 5
    setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
    heightAnchor.constraint(equalToConstant: 50).isActive = true
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
