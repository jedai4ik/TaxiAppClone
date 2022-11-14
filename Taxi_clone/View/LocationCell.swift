//
//  LocationCell.swift
//  Taxi_clone
//
//  Created by Timophey Ivanenko on 13.11.2022.
//

import UIKit

class LocationCell: UITableViewCell {
  
  // MARK: - Properties
  
  var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.text = "11 Rustaveli"
    return label
  }()
  
  var adressLabel: UILabel = {
    let label = UILabel()
    label.font =  UIFont.systemFont(ofSize: 14)
    label.textColor = .lightGray
    label.text = "11 Rustaveli, Batumi, Adjaria"
    return label
  }()
  
  // MARK: - Lifecycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    let stack = UIStackView(arrangedSubviews: [titleLabel, adressLabel])
    stack.axis = .vertical
    stack.distribution = .fillEqually
    stack.spacing = 4
    
    addSubview(stack)
    stack.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
