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
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Tim Iva"
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .darkGray
    return label
  }()
  
  let indicatorView1: UIView = {
    let view = UIView()
    view.backgroundColor = .darkGray
    view.setDimensions(height: 5, width: 5)
    return view
  }()
  
  let indicatorView2: UIView = {
    let view = UIView()
    view.backgroundColor = .darkGray
    view.setDimensions(height: 5, width: 5)
    return view
  }()
  
  let indicatorView3: UIView = {
    let view = UIView()
    view.backgroundColor = .darkGray
    view.setDimensions(height: 5, width: 5)
    return view
  }()

  
  private lazy var startingLocationTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Current Location"
    tf.backgroundColor = .systemGray4
    tf.isEnabled = false
    tf.font = UIFont.systemFont(ofSize: 14)
    tf.layer.cornerRadius = 10
    
    let paddingView = UIView()
    paddingView.setDimensions(height: 30, width: 30)
    tf.leftView = paddingView
    tf.leftViewMode = .always
    tf.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
    return tf
  }()
  
  private lazy var destinationLocationTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Enter a destination"
    tf.backgroundColor = .lightGray
    tf.returnKeyType = .search
    tf.font = UIFont.systemFont(ofSize: 14)
    tf.layer.cornerRadius = 10
    
    let paddingView = UIView()
    paddingView.setDimensions(height: 30, width: 30)
    tf.leftView = paddingView
    tf.leftViewMode = .always
    tf.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
    return tf
  }()
  
   
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addShadow()
    backgroundColor = .white
    
    addSubview(backButton)
    backButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 50,
                      paddingLeft: 12, width: 24, height: 25)
    
    addSubview(titleLabel)
    titleLabel.centerY(inView: backButton )
    titleLabel.centerX(inView: self)
    
    let indicatorStackView = UIStackView(arrangedSubviews: [indicatorView1,
                                                            indicatorView2,
                                                            indicatorView3])
    indicatorStackView.axis = .vertical
    indicatorStackView.distribution = .fill
    indicatorStackView.spacing = 20
    indicatorStackView.layoutIfNeeded()
    addSubview(indicatorStackView)
    indicatorStackView.anchor(top: backButton.bottomAnchor, left: leftAnchor, paddingTop: 25, paddingLeft: 10)
    
    
    let stackView = UIStackView(arrangedSubviews: [startingLocationTextField,
                                                  destinationLocationTextField])
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.spacing = 20
    

    addSubview(stackView)
    stackView.anchor(top: titleLabel.bottomAnchor, left: indicatorStackView.rightAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 16, paddingRight: 16)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Selectors
  
  @objc func handleBackTap() {
    delegate?.dismissChooseLocationView()
  }
  
  // MARK: - Animations
  
  func animateIndicator() {
    
    let opacityAnimation1 = CABasicAnimation(keyPath: "opacity")
    opacityAnimation1.fromValue = 1
    opacityAnimation1.toValue = 0
    opacityAnimation1.duration = 0.9
    opacityAnimation1.repeatDuration = .infinity
    opacityAnimation1.fillMode = .forwards
    opacityAnimation1.isRemovedOnCompletion = false
    opacityAnimation1.beginTime = CACurrentMediaTime()
    indicatorView1.layer.add(opacityAnimation1, forKey: nil)
    
    let opacityAnimation2 = CABasicAnimation(keyPath: "opacity")
    opacityAnimation2.fromValue = 1
    opacityAnimation2.toValue = 0
    opacityAnimation2.duration = 0.9
    opacityAnimation2.repeatDuration = .infinity
    opacityAnimation2.fillMode = .forwards
    opacityAnimation2.isRemovedOnCompletion = false
    opacityAnimation2.beginTime = CACurrentMediaTime()+0.3
    indicatorView2.layer.add(opacityAnimation2, forKey: nil)
    
    let opacityAnimation3 = CABasicAnimation(keyPath: "opacity")
    opacityAnimation3.fromValue = 1
    opacityAnimation3.toValue = 0
    opacityAnimation3.duration = 0.9
    opacityAnimation3.repeatDuration = .infinity
    opacityAnimation3.fillMode = .forwards
    opacityAnimation3.isRemovedOnCompletion = false
    opacityAnimation3.beginTime = CACurrentMediaTime()+0.6
    indicatorView3.layer.add(opacityAnimation3, forKey: nil)
    
  }
  
  
}
