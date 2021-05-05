//
//  Cars.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 4/30/21.
//

import UIKit
import Firebase

struct Car: Codable {
    
    public let carBrand, carModel, carBirth, carPower, carCapacity, carPrice, carKMPassed, carDesc, photoURL : String
//
//    init(carBrand: String, carModel: String, carBirth: String, carHorsePower: String, carCapacity: String,carPrice: String, carKMPassed: String, carDesc: String, photoURL: String, documentID: String) {
//

//        self.carBrand = carBrand
//        self.carModel = carModel
//        self.carBirth = carBirth
//        self.carHorsePower = carHorsePower
//        self.carCapacity = carCapacity
//        self.carPrice = carPrice
//        self.carKMPassed = carKMPassed
//        self.carDesc = carDesc
//        self.photoURL = photoURL
//
//    }
    
//    init(dictionary: [AnyHashable: Any]) {
//
//        self.carImageDesc = dictionary["carImageDesc"] as? String
//        self.carBrand = dictionary["carBrand"] as? String
//        self.carModel = dictionary["carModel"] as? String
//        self.carBirth = dictionary["carBirth"] as? String
//        self.carHorsePower = dictionary["carHorsePower"] as? String
//        self.carCapacity = dictionary["carCapacity"] as? String
//        self.carPrice = dictionary["carPrice"] as? String
//        self.carKMPassed = dictionary["carKMPassed"] as? String
//        self.carDesc = dictionary["carDesc"] as? String
//        self.photoURL = dictionary["photoURL"] as? String
//        self.documentID = dictionary["documentID"] as? String
//    }
//
//    override convenience init() {
//        self.init(carImageDesc: "", carBrand: "", carModel: "", carBirth: "", carHorsePower: "", carCapacity: "", carPrice: "", carKMPassed: "", carDesc: "", photoURL: "", documentID: "")
//    }
//
//    convenience init(dictionary: [String: Any]) {
//        let carImageDesc = dictionary["carImageDesc"] as! String? ?? ""
//        let carBrand = dictionary["carBrand"] as! String? ?? ""
//        let carModel = dictionary["carModel"] as! String? ?? ""
//        let carBirth = dictionary["carBirth"] as! String? ?? ""
//        let carHorsePower = dictionary["carHorsePower"] as! String? ?? ""
//        let carCapacity = dictionary["carCapacity"] as! String? ?? ""
//        let carPrice = dictionary["carPrice"] as! String? ?? ""
//        let carKMPassed = dictionary["carKMPassed"] as! String? ?? ""
//        let carDesc = dictionary["carDesc"] as! String? ?? ""
//        let photoURL = dictionary["photoURL"] as! String? ?? ""
//        let documentID = dictionary["documentID"] as! String? ?? ""
//        self.init(carImageDesc: carImageDesc, carBrand: carBrand, carModel: carModel, carBirth: carBirth, carHorsePower: carHorsePower, carCapacity: carCapacity, carPrice: carPrice, carKMPassed: carKMPassed, carDesc: carDesc, photoURL: photoURL, documentID: documentID)
//    }
    
   
    
//    var dictionary: [String: Any] {
//        return ["carBrand": carBrand, "carModel": carModel, "carBirth": carBirth, "carHorsePower": carHorsePower, "carCapacity": carCapacity, "carPrice": carPrice, "carKMPassed": carKMPassed, "carDesc": carDesc]
//    }
    
//    convenience init() {
//        let authUserID = Auth.auth().currentUser?.uid ?? ""
//        
//        self.init(carImageDesc: "", carBrand: "", carModel: "", carBirth: "", carHorsePower: "", carCapacity: "", carPrice: "", carKMPassed: "", carDesc: "", documentID: "")
//        
//    }
    
//    public let carBrand: String
//    public let carModel: String
//    public let carBirth: String
//    public let carHorsePower: String
//    public let carCapacity: String
//    public let carPrice: String
//    public let carKMPassed: String
//    public let carDescription: String
    
}

