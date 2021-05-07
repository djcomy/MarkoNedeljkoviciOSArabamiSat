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
    
}
