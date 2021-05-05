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
    
    init(car: Car) {
        
        self.photoURL = car.photoURL
        self.carBrand = car.carBrand
        self.carModel = car.carModel
        self.carBirth = car.carBirth
    }
}

