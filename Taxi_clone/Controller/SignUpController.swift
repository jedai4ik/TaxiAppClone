//
//  SignUpController.swift
//  Taxi_clone
//
//  Created by Timophey Ivanenko on 01.11.2022.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
  
  //MARK: - Properties
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "GetTaxi"
    label.font = UIFont(name: "Avenir", size: 36)
    label.textColor = UIColor(white: 1, alpha: 0.8)
    return label
  }()
  
  private lazy var emailContainerView: UIView = {
    let view =  UIView().inputContainerView(image: UIImage(named: "ic_mail_outline_white_2x")!, textField: emailTextField )
    view.heightAnchor.constraint(equalToConstant: 50).isActive = true
    return view
  }()
  
  private lazy var passwordContainerView: UIView = {
    let view =  UIView().inputContainerView(image: UIImage(named: "ic_lock_outline_white_2x")!, textField: passwordTextField )
    view.heightAnchor.constraint(equalToConstant: 50).isActive = true
    return view
  }()
  
  private lazy var nameContainerView: UIView = {
    let view =  UIView().inputContainerView(image: UIImage(named: "ic_person_outline_white_2x")!, textField: nameTextField )
    view.heightAnchor.constraint(equalToConstant: 50).isActive = true
    return view
  }()
  
  private lazy var accountTypeContainerView: UIView = {
    let view =  UIView().inputContainerView(image: UIImage(named: "ic_account_box_white_2x")!, segmentedControl: accountTypeSegmentedControl )
    view.heightAnchor.constraint(equalToConstant: 120).isActive = true
    return view
  }()
  
  private let emailTextField: UITextField = {
    return UITextField().textField(withPlaceholder: "Email",
                                   isSecureTextEntry: false)
  }()
  
  private let nameTextField: UITextField = {
    return UITextField().textField(withPlaceholder: "Full Name",
                                   isSecureTextEntry: false)
  }()
  
  private let passwordTextField: UITextField = {
    return UITextField().textField(withPlaceholder: "Password",
                                   isSecureTextEntry: true)
  }()
  
  private let signUpButton: AuthButton = {
    let button = AuthButton(type: .system)
    button.setTitle("Sign Up", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    return button
  }()
  
  private let accountTypeSegmentedControl: UISegmentedControl = {
    let sc = UISegmentedControl(items: ["Rider", "Driver"])
    sc.backgroundColor = .backgroundColor
    sc.tintColor = UIColor(white: 1, alpha: 0.87)
    sc.selectedSegmentIndex = 0
    return sc
  }()
  
  let alreadyHaveAccountButton: UIButton = {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes:
                                                      [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                                       NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    attributedTitle.append(NSAttributedString(string: "Sign in", attributes:
                                                [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                                                 NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(handleShowLoginController), for: .touchUpInside)
    return button
  }()
  
  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    
  }
  
  //MARK: - Selectors
  
  @objc func handleShowLoginController() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func handleSignUp() {
    guard let email = emailTextField.text else { return }
    guard let password = passwordTextField.text else { return }
    guard let fullname = nameTextField.text else { return }
    let accountTypeIndex = accountTypeSegmentedControl.selectedSegmentIndex
            
    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
      if let error = error {
        print("Failed to register user with errror \(error)")
        return
      }
      guard let uid = result?.user.uid else { return }
      let values = ["email": email,
                    "fullname": fullname,
                    "accountType": accountTypeIndex] as [ String : Any ]
      Database.database().reference().child("users").child(uid).updateChildValues(values) { error, reference in
        if let error = error {
          print("Firebase error \(error)")
        }
        guard let controller = UIApplication.shared.keyWindow?.rootViewController as? HomeController else { return }
        controller.configureUI()
        self.dismiss(animated: true, completion: nil)
      }
    }
  }
  
  func configureUI() {
    view.backgroundColor = .backgroundColor
    view.addSubview(titleLabel)
    titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
    titleLabel.centerX(inView: view)
    
    
    let stackView = UIStackView(arrangedSubviews: [emailContainerView,
                                                   nameContainerView,
                                                   passwordContainerView,
                                                   accountTypeContainerView,
                                                    signUpButton])
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.spacing = 18

    view.addSubview(stackView)
    stackView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 16, paddingRight: 16)
    
    view.addSubview(alreadyHaveAccountButton)
    alreadyHaveAccountButton.centerX(inView: view)
    alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
  }
  
  
  
}
