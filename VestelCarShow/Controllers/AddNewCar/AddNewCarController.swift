//
//  AddNewCarController.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 4/30/21.
//

import UIKit
import Firebase

class AddNewCarController: UIViewController {
    
    var documentUUID: String = ""
    var carBrand = "", carModel = "", carBirth = "", carPower = "", carCapacity = "", carPrice = "", carKMPassed = "", carDesc = "", documentID = "", photoURL = ""
    

    lazy var carImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NewCarImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectedCarImageView)))
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    lazy var carBrandTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Car Brand", isSecureTextEntry: false)
    }()
    
    lazy var carModelTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Car Model", isSecureTextEntry: false)
    }()
    
    lazy var carBirthTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Year of manufacturing", isSecureTextEntry: false)
    }()
    
    lazy var carHorsePowerTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Horse Power", isSecureTextEntry: false)
    }()
    
    lazy var carCapacityTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Engine Capacity", isSecureTextEntry: false)
    }()
    
    lazy var carPriceTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Car Price", isSecureTextEntry: false)
    }()
    
    lazy var carKMPassedTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Total KM passed", isSecureTextEntry: false)
    }()
    
    lazy var carDescTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Car Description", isSecureTextEntry: false)
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        carImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectedCarImageView)))
        carImageView.isUserInteractionEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        carModelTextField.backgroundColor = UIColor(white: 1, alpha: 0.7)
        carModelTextField.layer.cornerRadius = 5
    }
    
    @objc func cancelAddingNewCar() {

        _ = navigationController?.popViewController(animated: true)

    }

    func updateUploadValues() {
        carBrand = carBrandTextField.text!
        carModel = carModelTextField.text!
        carBirth = carBirthTextField.text!
        carPower = carHorsePowerTextField.text!
        carCapacity = carCapacityTextField.text!
        carPrice = carPriceTextField.text!
        carKMPassed = carKMPassedTextField.text!
        carDesc = carDescTextField.text!
    }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func saveToFirebase() {

        updateUploadValues()
        
        saveData { success in
            if success {
                self.leaveViewController()
            } else {
                print("*** ERROR: Couldn't leave this view controller because data wasn't saved.")
            }
        }
    }
    
    func configureViewComponents() {
        view.backgroundColor = UIColor.mainBlue()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor.lightGray
        navigationItem.title = "Add a new Car"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_arrow_back_white_24dp"), style: .plain, target: self, action: #selector(cancelAddingNewCar))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_arrow_back_white_24dp"), style: .plain, target: self, action: #selector(saveToFirebase))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        view.addSubview(carImageView)
        carImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 350, height: 150)
        carImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(carBrandTextField)
        carBrandTextField.anchor(top: carImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 40)
        
        view.addSubview(carModelTextField)
        carModelTextField.anchor(top: carBrandTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 40)
        
        view.addSubview(carBirthTextField)
        carBirthTextField.anchor(top: carModelTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 40)
        
        view.addSubview(carHorsePowerTextField)
        carHorsePowerTextField.anchor(top: carBirthTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 40)
        
        view.addSubview(carCapacityTextField)
        carCapacityTextField.anchor(top: carHorsePowerTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 40)
        
        view.addSubview(carPriceTextField)
        carPriceTextField.anchor(top: carCapacityTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 40)
        view.addSubview(carKMPassedTextField)
        carKMPassedTextField.anchor(top: carPriceTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 40)
        view.addSubview(carDescTextField)
        carDescTextField.anchor(top: carKMPassedTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 100)

    }
}
