//
//  HomeController.swift
//  Taxi_clone
//
//  Created by Timophey Ivanenko on 07.11.2022.
//

import UIKit
import Firebase
import MapKit

private let reuseIdentifier = "LocationCell"

class HomeController: UIViewController {
  
  // MARK: - Properties
  
  private let mapView = MKMapView()
  private let locationManager = CLLocationManager()
  private let locationInputView = LocationInputView()
  private let chooseLocationView = ChooseLocationView()
  private let tableView = UITableView()
  private final let chooseLocationViewHeight: CGFloat = 200
  
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
    configureTableView()
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
                              right: view.rightAnchor, height: chooseLocationViewHeight)
    chooseLocationView.alpha = 0
    
    UIView.animate(withDuration: 0.3, animations: {
      self.chooseLocationView.alpha = 1
      self.chooseLocationView.animateIndicator()
      
    }) { _ in
      UIView.animate(withDuration: 0.3) {
        self.tableView.frame.origin.y = self.chooseLocationViewHeight
      }
    }
  }
  
  func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(LocationCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.rowHeight = 60
    tableView.tableFooterView = UIView()
    let height = view.frame.height - chooseLocationViewHeight
    tableView.frame = CGRect(x: 0, y: view.frame.height,
                             width: view.frame.width, height: height)
    view.addSubview(tableView)
    
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
  
  func dismissChooseLocation() {
    UIView.animate(withDuration: 0.3, animations: {
      self.chooseLocationView.alpha = 0
      self.tableView.frame.origin.y = self.view.frame.height
    }) { _ in
      self.chooseLocationView.removeFromSuperview()
      UIView.animate(withDuration: 0.3, animations: {
        self.locationInputView.alpha = 1
      })
    }
  }
}


// MARK: - UITableViewDelegate/UITableViewDataSource

extension HomeController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    section == 0 ? 2 : 5
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    2
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    "Test"
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LocationCell
    return cell
  }
  
  
}
