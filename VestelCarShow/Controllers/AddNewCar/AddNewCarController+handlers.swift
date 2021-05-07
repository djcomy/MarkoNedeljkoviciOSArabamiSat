//
//  LoginViewController+handlers.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 4/30/21.
//

import UIKit
import Photos
import Firebase

extension AddNewCarController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func saveData(completed: @escaping (Bool) -> ()) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // Convert photo.image to a Data type so it can be saved by Firebase Storage
        guard let photoData = self.carImageView.image?.jpegData(compressionQuality: 0.01) else {
            print("*** ERROR: couuld not convert image to data format")
            return
        }
        // Create metadata so that we can see images in Firebase Storage Console
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        // generate a unique ID to use for the photo image's name
        //let imageName = UUID().uuidString
        
        if photoURL == "" {
            photoURL = UUID().uuidString
        }
        
        // create a ref to upload storage to spot.photoURL's folder (bucket), with the name we created.
        let storageRef = StorageDB.reference().child(uid).child("\(photoURL).jpg")
        // Create an uploadTask
        
        storageRef.putData(photoData, metadata: uploadMetadata) {metadata, error in
            guard error == nil, metadata != nil else {
                print("😡 ERROR during .putData storage upload for reference \(storageRef). Error: \(error!.localizedDescription)")
                return
            }
            
            storageRef.downloadURL(completion: { (url, err) in
                if let err = err {
                    print(err)
                    return
                }
                guard let url = url else{
                    return
                    
                }
                
                print("😎 Upload worked! Metadata is \(url)")
                
                let dataReference = FirestoreDB.collection(uid).document()
                
                let urlString = url.absoluteString
                
                var data: [String: Any] {
                    
                    return ["carBrand": self.carBrand, "carModel": self.carModel, "carBirth": self.carBirth, "carHorsePower": self.carPower, "carCapacity": self.carCapacity,
                            "carPrice": self.carPrice, "carKMPassed": self.carKMPassed, "carDesc": self.carDesc, "documentID": self.documentID, "photoURL": urlString]
                }
                
                
                
                dataReference.setData(data) { (err) in
                    if let err = err {
                        print(err)
                        completed(false)
                        return
                    } else {
                        completed(true)
                    }
                }
            })
        }
    }
    
    @objc func handleSelectedCarImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            carImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
