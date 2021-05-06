//
//  RealmObjects.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 5/5/21.
//

import Foundation
import RealmSwift


@objcMembers class RealmViewModel: Object {
    
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

