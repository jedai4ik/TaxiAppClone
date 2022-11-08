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
  private let locationManager = CLLocationManager()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    checkIfUserIsLoggedIn()
    enableLocationServices()
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
    configureMapView()
  }
  
  func configureMapView() {
    view.addSubview(mapView)
    mapView.frame = view.frame
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
  }
}

//MARK: - LocationServices

extension HomeController: CLLocationManagerDelegate {
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    print(#function)
    locationManager.requestAlwaysAuthorization()
  }
 
  func enableLocationServices() {
    switch locationManager.authorizationStatus {
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
      print("Not determined")
    case .restricted, .denied:
      break
    case .authorizedAlways:
      locationManager.startUpdatingLocation()
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      print("Auth always")
    case .authorizedWhenInUse:
      locationManager.requestAlwaysAuthorization()
      print("Auth when in use")
    default:
      break
    }
  }
  
}
