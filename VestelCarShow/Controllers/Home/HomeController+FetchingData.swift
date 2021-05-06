//
//  HomeController+FetchingData.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 5/4/21.
//
import Foundation
import UIKit
import Firebase

extension HomeController {
    
    func loadUserData() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        USERS_REF.child(uid).child("username").observeSingleEvent(of: .value) { (snapshot) in
            guard let username = snapshot.value as? String else { return }
            print(snapshot)
            self.navigationItem.title = "Hello, \(username)"
            self.welcomeLabel.tintColor = .darkGray
            UIView.animate(withDuration: 0.5, animations: {
                self.welcomeLabel.alpha = 1
            })
        }
        
        FirestoreDB.collection(uid).addSnapshotListener { [weak self] (querySnapshot, error) in
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self?.carsViewModel = documents.map { querySnapshot -> CarsViewModel in
                    let data = querySnapshot.data()
                    
                    let carBrand = data["carBrand"] as? String ?? ""
                    let carModel = data["carModel"] as? String ?? ""
                    let carBirth = data["carBirth"] as? String ?? ""
                    let carPower = data["carPower"] as? String ?? ""
                    let carCapacity = data["carCapacity"] as? String ?? ""
                    let carPrice = data["carPrice"] as? String ?? ""
                    let carKMPassed = data["carKMPassed"] as? String ?? ""
                    let carDesc = data["carDesc"] as? String ?? ""
                    let carImage = data["photoURL"] as? String ?? ""
                    
                    return CarsViewModel(car: Car(carBrand: carBrand, carModel: carModel, carBirth: carBirth, carPower: carPower, carCapacity: carCapacity, carPrice: carPrice, carKMPassed: carKMPassed, carDesc: carDesc, photoURL: carImage))
                    
                }
                self?.collectionView.reloadData()
            }
        }
    }
}
