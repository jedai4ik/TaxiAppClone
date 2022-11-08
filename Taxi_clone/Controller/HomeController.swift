//
//  HomeController.swift
//  Taxi_clone
//
//  Created by Timophey Ivanenko on 07.11.2022.
//

import UIKit
import Firebase
import MapKit

class HomeController: UIViewController {
  
  // MARK: - Properties
  
  private let mapView = MKMapView()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    checkIfUserIsLoggedIn()
  }
  
  // MARK: - API
  
  func checkIfUserIsLoggedIn() {
    if Auth.auth().currentUser?.uid == nil {
      print("User not logged in")
      DispatchQueue.main.async {
        let nav = UINavigationController(rootViewController: LoginViewController())
        self.present(nav, animated: true, completion: nil)
      }
    } else {
      configureUI()
    }
  }
  
  func signOut() {
    do {
      try Auth.auth().signOut()
    } catch {
      print("Error signing out")
    }
  }
  
  //MARK: - Helper Functions
  
  func configureUI() {
    view.addSubview(mapView)
    mapView.frame = view.frame
  }
}
