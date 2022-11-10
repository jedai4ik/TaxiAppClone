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
  private let locationInputView = LocationInputView()
  private let chooseLocationView = ChooseLocationView()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    checkIfUserIsLoggedIn()
    enableLocationServices()
  }
  
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      navigationController?.setNavigationBarHidden(false, animated: animated)
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
    
    view.addSubview(locationInputView)
    locationInputView.centerX(inView: view)
    locationInputView.setDimensions(height: 50, width: view.frame.width - 64)
    locationInputView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
    locationInputView.delegate = self
    chooseLocationView.delegate = self
    
    locationInputView.alpha = 0
    
    UIView.animate(withDuration: 1) {
      self.locationInputView.alpha = 1
    }
  }
  
  func configureMapView() {
    view.addSubview(mapView)
    mapView.frame = view.frame
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
  }
  
  func configureChooseLocationView() {
    view.addSubview(chooseLocationView)
    chooseLocationView.anchor(top: view.topAnchor, left: view.leftAnchor,
                              right: view.rightAnchor, height: 200)
    chooseLocationView.alpha = 0
    
    UIView.animate(withDuration: 0.3, animations: {
      self.chooseLocationView.alpha = 1
    }) { _ in
      print("Present table view")
    }
  }
  
  func dismissChooseLocation() {
    UIView.animate(withDuration: 0.3, animations: {
      self.chooseLocationView.alpha = 0
    }) { _ in
      UIView.animate(withDuration: 0.3, animations: {
        self.locationInputView.alpha = 1
      })
      
    }
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

extension HomeController: LocationInputViewDelegate {
  func presentLocationInputViewDelegate() {
    locationInputView.alpha = 0
    configureChooseLocationView()
  }
}

extension HomeController: ChooseLocationViewDelegate {
  func dismissChooseLocationView() {
    dismissChooseLocation()
  }
  
  
}
