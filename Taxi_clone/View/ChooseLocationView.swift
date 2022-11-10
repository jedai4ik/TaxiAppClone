//
//  ChooseLocationView.swift
//  Taxi_clone
//
//  Created by Timophey Ivanenko on 10.11.2022.
//

import UIKit

protocol ChooseLocationViewDelegate: AnyObject {
  func dismissChooseLocationView()
}

class ChooseLocationView: UIView {
  
  // MARK: - Properties
  
  weak var delegate: ChooseLocationViewDelegate?
  
  private let backButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "baseline_arrow_back_black_36dp")?.withRenderingMode(.alwaysOriginal), for: .normal)
    button.addTarget(self, action: #selector(handleBackTap), for: .touchUpInside)
    return button
  }()
  
  
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addShadow()
    backgroundColor = .white
    
    addSubview(backButton)
    backButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 44,
                      paddingLeft: 12, width: 24, height: 25)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK - Selectors
  
  @objc func handleBackTap() {
    delegate?.dismissChooseLocationView()
  }
  
}
