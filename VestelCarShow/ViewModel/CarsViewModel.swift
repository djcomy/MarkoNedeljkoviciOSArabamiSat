//
//  CarsViewModel.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 4/30/21.
//

import Foundation
import UIKit
import Firebase

class CarsViewModel {

    var photoURL: String?
    var carBrand: String?
    var carModel: String?
    var carBirth: String?
    var carPower: String?
    var carCapacity: String?
    var carKMPassed: String?
    var carPrice: String?
    var carDesc: String?
    
    init(car: Car) {
        
        self.photoURL = car.photoURL
        self.carBrand = car.carBrand
        self.carModel = car.carModel
        self.carBirth = car.carBirth
        self.carPower = car.carPower
        self.carCapacity = car.carCapacity
        self.carKMPassed = car.carKMPassed
        self.carPrice = car.carPrice
        self.carDesc = car.carDesc
    }
}

