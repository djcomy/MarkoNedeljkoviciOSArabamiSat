//
//  AddNewCarController.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 4/30/21.
//

import UIKit
import Firebase
import RealmSwift

class AddNewCarController: UIViewController {
    
    var person = Person()
    var realmStoredResults: Results<RealmViewModel>!
    var realmViewModel = [RealmViewModel]()
    var documentUUID: String = ""
    var carBrand = "", carModel = "", carBirth = "", carPower = "", carCapacity = "", carPrice = "", carKMPassed = "", carDesc = "", documentID = "", photoURL = ""
    
    
    lazy var carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NewCarImage")
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .darkGray
        imageView.layer.masksToBounds = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectedCarImageView)))
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    lazy var carBrandTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .darkGray
        tf.isSecureTextEntry = false
        tf.attributedPlaceholder = NSAttributedString(string:"Car Brand", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        return tf
    }()
    
    lazy var carModelTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .darkGray
        tf.isSecureTextEntry = false
        tf.attributedPlaceholder = NSAttributedString(string:"Car Model", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        return tf
    }()
    
    lazy var carBirthTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .darkGray
        tf.isSecureTextEntry = false
        tf.attributedPlaceholder = NSAttributedString(string:"Year manufactured", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        return tf
    }()
    
    lazy var carHorsePowerTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .darkGray
        tf.isSecureTextEntry = false
        tf.attributedPlaceholder = NSAttributedString(string:"Horse Power", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        return tf
    }()
    
    lazy var carCapacityTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .darkGray
        tf.isSecureTextEntry = false
        tf.attributedPlaceholder = NSAttributedString(string:"Engine capacity", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        return tf
    }()
    
    lazy var carPriceTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .darkGray
        tf.isSecureTextEntry = false
        tf.attributedPlaceholder = NSAttributedString(string:"Car price", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        return tf
    }()
    
    lazy var carKMPassedTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .darkGray
        tf.isSecureTextEntry = false
        tf.attributedPlaceholder = NSAttributedString(string:"Total KM passed", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        return tf
    }()
    
    lazy var carDescTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .darkGray
        tf.isSecureTextEntry = false
        tf.attributedPlaceholder = NSAttributedString(string:"Car description", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        return tf
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        carImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectedCarImageView)))
        carImageView.isUserInteractionEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.setupToHideKeyboardOnTapOnView()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - keyboardSize.height/2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    override func viewDidLayoutSubviews() {
        setUItextView(label: carBrandTextField)
        setUItextView(label: carModelTextField)
        setUItextView(label: carBirthTextField)
        setUItextView(label: carHorsePowerTextField)
        setUItextView(label: carCapacityTextField)
        setUItextView(label: carPriceTextField)
        setUItextView(label: carKMPassedTextField)
        setUItextView(label: carDescTextField)
        
    }
    
    
    func setUItextView(label: UITextField) {
        label.backgroundColor = PHColor
        label.layer.shadowColor = UIColor.darkGray.cgColor
        label.layer.shadowOpacity = 0.75
        label.layer.shadowOffset = .zero
        label.layer.shadowRadius = 2
        label.layer.cornerRadius = 5
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
        //saveToRealm()
        saveData { success in
            if success {
                self.saveToRealm()
                self.leaveViewController()
            } else {
                self.leaveViewController()
                print("*** ERROR: Couldn't leave this view controller because data wasn't saved.")
            }
        }
    }
    
    func saveToRealm() {
//        let data = NSData(data: carImageView.image!.jpegData(compressionQuality: 0.1)!)
//        let imageData = String(decoding: data, as: UTF8.self)
//
      let realmViewModel = RealmViewModel()
        
        realmViewModel.carBrand = carBrandTextField.text!
        realmViewModel.carModel = carModelTextField.text!
        realmViewModel.carBirth = carBirthTextField.text!
        realmViewModel.carPower = carHorsePowerTextField.text!
        realmViewModel.carCapacity = carCapacityTextField.text!
        realmViewModel.carPrice = carPriceTextField.text!
        realmViewModel.carKMPassed = carKMPassedTextField.text!
        realmViewModel.carDesc = carDescTextField.text!
        realmViewModel.carBrand = carBrandTextField.text!
       // realmViewModel.photoUrl = imageData
        
        let realmObjects = RealmViewModel(
            carBrand: realmViewModel.carBrand!,
            carModel: realmViewModel.carModel!,
            carBirth: realmViewModel.carBirth!,
            carPower: realmViewModel.carPower!,
            carCapacity: realmViewModel.carCapacity!,
            carPrice: realmViewModel.carPrice!,
            carKMPassed: realmViewModel.carKMPassed!,
            carDesc: realmViewModel.carDesc!,
            photoURL: "")
        
        //RealmService.shared.create(realmObjects)
        RealmViewModel.add(object: realmObjects)
    }
    
    func configureViewComponents() {
        let navBar = navigationController?.navigationBar
        view.backgroundColor = UIColor.white
        navBar!.barStyle = .black
        navBar!.barTintColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        navigationItem.title = "Add a new Car"
        navBar!.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.75
        navigationController?.navigationBar.layer.shadowOffset = .zero
        navigationController?.navigationBar.layer.shadowRadius = 2
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_arrow_back_white_24dp"), style: .plain, target: self, action: #selector(cancelAddingNewCar))
        navigationItem.leftBarButtonItem?.tintColor = .darkGray
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_confirm_back_white_24dp"), style: .plain, target: self, action: #selector(saveToFirebase))
        navigationItem.rightBarButtonItem?.tintColor = .darkGray
        
        view.addSubview(carImageView)
        carImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.bounds.width, height: 200)
        carImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(carBrandTextField)
        carBrandTextField.anchor(top: carImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 35)
        
        view.addSubview(carModelTextField)
        carModelTextField.anchor(top: carBrandTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 35)
        
        view.addSubview(carBirthTextField)
        carBirthTextField.anchor(top: carModelTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 35)
        
        view.addSubview(carHorsePowerTextField)
        carHorsePowerTextField.anchor(top: carBirthTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 35)
        
        view.addSubview(carCapacityTextField)
        carCapacityTextField.anchor(top: carHorsePowerTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 35)
        
        view.addSubview(carPriceTextField)
        carPriceTextField.anchor(top: carCapacityTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 35)
        
        view.addSubview(carKMPassedTextField)
        carKMPassedTextField.anchor(top: carPriceTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 35)
        
        view.addSubview(carDescTextField)
        carDescTextField.anchor(top: carKMPassedTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 75)
        
    }
}
