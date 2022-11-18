//
//  Service.swift
//  Taxi_clone
//
//  Created by Timophey Ivanenko on 16.11.2022.
//

import Firebase


let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")

struct Service {
  
  static let shared = Service()
  let currentUid = Auth.auth().currentUser?.uid
  
  func fetchUserData(completion: @escaping(User) -> Void) {
    if let currentUid = currentUid {
      REF_USERS.child(currentUid).observeSingleEvent(of: .value) { DataSnapshot in
        guard let dictionary = DataSnapshot.value as? [String: Any] else { return }
        let user = User(dictionary: dictionary)
        completion(user)
      }
    }
    
  }
}
