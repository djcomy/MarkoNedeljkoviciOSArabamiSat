////
////  SendToFirebaseClass.swift
////  VestelCarShow
////
////  Created by Marko Nedeljkovic on 5/2/21.
////
//
//import UIKit
//import Firebase
//
//class PhotoAndData {
//    
//    var documentUUID: String
//    var image: UIImage
//    var userID, carBrand, carModel, carBirth, carHorsePower, carCapacity, carPrice, carKMPassed, carDesc, photoURL, documentID : String
//    
//    var dictionary: [String: Any] {
//        
//        return ["userID": userID, "carBrand": carBrand, "carModel": carModel, "carBirth": carBirth, "carHorsePower": carHorsePower, "carCapacity": carCapacity,
//                "carPrice": carBrand, "carKMPassed": carModel, "carDesc": carBirth, "photoURL": carHorsePower, "documentID": carCapacity]
//    }
//    
//    
//    
//    init(image: UIImage, userID: String, carBrand: String, carModel: String, carBirth: String, carHorsePower: String, carCapacity: String,carPrice: String, carKMPassed: String, carDesc: String, photoURL: String, documentID: String) {
//       
//        self.image = image
//        self.userID = userID
//        self.carBrand = carBrand
//        self.carModel = carModel
//        self.carBirth = carBirth
//        self.carHorsePower = carHorsePower
//        self.carCapacity = carCapacity
//        self.carPrice = carPrice
//        self.carKMPassed = carKMPassed
//        self.carDesc = carDesc
//        self.photoURL = photoURL
//        self.documentID = documentID
//        
//    }
//
//    convenience init() {
//        let userID = Auth.auth().currentUser?.uid ?? ""
//        self.init(image: UIImage(), userID: userID, carBrand: carBrand, carModel: carModel, carBirth: carBirth, carHorsePower: carHorsePower, carCapacity: carCapacity, carPrice: carPrice, carKMPassed: carKMPassed, carDesc: carDesc, photoURL: "", documentID: "")
//    }
//    
//    convenience init(dictionary: [String: Any]) {
//        let userID = dictionary["userID"] as! String? ?? ""
//        let carBrand = dictionary["carBrand"] as! String? ?? ""
//        let carModel = dictionary["carModel"] as! String? ?? ""
//        let carBirth = dictionary["carBirth"] as! String? ?? ""
//        let carHorsePower = dictionary["carHorsePower"] as! String? ?? ""
//        let carCapacity = dictionary["carCapacity"] as! String? ?? ""
//        let carPrice = dictionary["carPrice"] as! String? ?? ""
//        let carKMPassed = dictionary["carKMPassed"] as! String? ?? ""
//        let carDesc = dictionary["carDesc"] as! String? ?? ""
//        let carPhotoUrl = dictionary["carPhotoUrl"] as! String? ?? ""
//        self.init(image: UIImage(), userID: userID, carBrand: carBrand, carModel: carModel, carBirth: carBirth, carHorsePower: carHorsePower, carCapacity: carCapacity, carPrice: carPrice, carKMPassed: carKMPassed, carDesc: carDesc, photoURL: carPhotoUrl, documentID: "")
//    }
//    
//    func saveData(spot: Cars, completed: @escaping (Bool) -> ()) {
//        let db = Firestore.firestore()
//        let storage = Storage.storage()
//        // convert photo.image to a Data type so it can be saved by Firebase Storage
//        guard let photoData = self.image.jpegData(compressionQuality: 0.5) else {
//            print("*** ERROR: couuld not convert image to data format")
//            return completed(false)
//        }
//        let uploadMetadata = StorageMetadata()
//        uploadMetadata.contentType = "image/jpeg"
//        documentUUID = UUID().uuidString // generate a unique ID to use for the photo image's name
//        // create a ref to upload storage to spot.documentID's folder (bucket), with the name we created.
//        let storageRef = storage.reference().child(spot.documentID).child(self.documentUUID)
//        let uploadTask = storageRef.putData(photoData, metadata: uploadMetadata) {metadata, error in
//            guard error == nil else {
//                print("😡 ERROR during .putData storage upload for reference \(storageRef). Error: \(error!.localizedDescription)")
//                return
//            }
//            print("😎 Upload worked! Metadata is \(metadata!)")
//        }
//        
//        uploadTask.observe(.success) { (snapshot) in
//            // Create the dictionary representing the data we want to save
//            let dataToSave = self.dictionary
//            // This will either create a new doc at documentUUID or update the existing doc with that name
//            let ref = db.collection("spots").document(spot.documentID).collection("photos").document(self.documentUUID)
//            ref.setData(dataToSave) { (error) in
//                if let error = error {
//                    print("*** ERROR: updating document \(self.documentUUID) in spot \(spot.documentID) \(error.localizedDescription)")
//                    completed(false)
//                } else {
//                    print("^^^ Document updated with ref ID \(ref.documentID)")
//                    completed(true)
//                }
//            }
//        }
//        
//        uploadTask.observe(.failure) { (snapshot) in
//            if let error = snapshot.error {
//                print("*** ERROR: upload task for file \(self.documentUUID) failed, in spot \(spot.documentID), error \(error)")
//            }
//            return completed(false)
//        }
//    }
//    
//    func loadImage(spot: Cars, completion: @escaping (Bool) -> ()) {
//        guard spot.documentID != "" else {
//            print("😡 ERROR: did not pass a valid spot into loadImage")
//            return
//        }
//        let storage = Storage.storage()
//        let storageRef = storage.reference().child(spot.documentID).child(documentID)
//        storageRef.getData(maxSize: 25 * 1024 * 1024) { (data, error) in
//            if let error = error {
//                print("ERROR: an error occurred while reading data from file ref: \(storageRef) error = \(error.localizedDescription)")
//                return completion(false)
//            } else {
//                self.image = UIImage(data: data!) ?? UIImage()
//                return completion(true)
//            }
//        }
//    }
//}
//
