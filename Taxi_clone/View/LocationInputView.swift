//
//  LocationInputView.swift
//  Taxi_clone
//
//  Created by Timophey Ivanenko on 10.11.2022.
//

import UIKit

protocol LocationInputViewDelegate: AnyObject {
  func presentLocationInputViewDelegate()
}

class LocationInputView: UIView {
  
  //MARK: - Properties
  
  weak var delegate: LocationInputViewDelegate?
  
  private let indicatorView: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    return view
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Where to?"
    label.font = UIFont.systemFont(ofSize: 18)
    label.textColor = .darkGray
    return label
  }()
  
  //MARK: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    layer.cornerRadius = 10
    addShadow()
    addSubview(indicatorView)
    
    indicatorView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 16)
    indicatorView.setDimensions(height: 6, width: 6)
    
    addSubview(titleLabel)
    titleLabel.centerY(inView: self, leftAnchor: indicatorView.rightAnchor, paddingLeft: 20 )
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(presentLocationInputView))
    addGestureRecognizer(tap)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Selectors
  @objc func presentLocationInputView() {
    delegate?.presentLocationInputViewDelegate()
  }
  
  
}
