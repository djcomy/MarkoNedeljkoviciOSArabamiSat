//
//  RealmObjects.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 5/5/21.
//

import Foundation
import RealmSwift


@objcMembers class RealmViewModel: Object {
    
    enum Property: String {
      case isCompleted
    }
    
    dynamic var personID = uid
    dynamic var carBrand : String? = ""
    dynamic var carModel : String? = ""
    dynamic var carBirth : String? = ""
    dynamic var carPower : String? = ""
    dynamic var carCapacity : String? = ""
    dynamic var carPrice : String? = ""
    dynamic var carDesc : String? = ""
    dynamic var carKMPassed : String? = ""
    dynamic var photoUrl : String? = ""
    dynamic var isCompleted = false
    
    convenience init(carBrand: String, carModel: String, carBirth: String?, carPower: String?, carCapacity: String, carPrice: String, carKMPassed: String, carDesc: String, photoURL: String) {
        
        self.init()
        
        self.carBrand = carBrand
        self.carModel = carModel
        self.carBirth = carBirth
        self.carPower = carPower
        self.carCapacity = carCapacity
        self.carPrice = carPrice
        self.carKMPassed = carKMPassed
        self.carDesc = carDesc
        self.photoUrl = photoURL
        
    }
    override static func primaryKey() -> String? {
        return "personID"
    }
}
extension RealmViewModel {

    static func all(in realm: Realm = try! Realm()) -> Results<RealmViewModel> {
      return realm.objects(RealmViewModel.self)
        .sorted(byKeyPath: RealmViewModel.Property.isCompleted.rawValue)
    }
    
    @discardableResult
    static func add(object: RealmViewModel?, in realm: Realm = try! Realm())
      -> RealmViewModel {
        let item = RealmViewModel(value: object as Any)
        try! realm.write {
          realm.add(item)
        }
        return item
    }
    
    func toggleCompleted() {
      guard let realm = realm else { return }
      try! realm.write {
        isCompleted = !isCompleted
      }
    }
}
