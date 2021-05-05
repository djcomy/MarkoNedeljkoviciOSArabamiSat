////
////  FetchingServise.swift
////  VestelCarShow
////
////  Created by Marko Nedeljkovic on 5/4/21.
////
//
//
//import UIKit
//import Firebase
//
//class CarDetailController: UIViewController {
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureViewComponents()
//        //carImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectedCarImageView)))
//        //carImageView.isUserInteractionEnabled = true
//    }
//    
//    func leaveViewController() {
//        let isPresentingInAddMode = presentingViewController is UINavigationController
//        if isPresentingInAddMode {
//            dismiss(animated: true, completion: nil)
//        } else {
//            navigationController?.popViewController(animated: true)
//        }
//    }
//    
//    func configureViewComponents() {
//        view.backgroundColor = UIColor.mainBlue()
//        navigationController?.navigationBar.barStyle = .black
//        navigationController?.navigationBar.barTintColor = UIColor.lightGray
//        navigationItem.title = "Add a new Car"
//        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_arrow_back_white_24dp"), style: .plain, target: self, action: #selector(cancelAddingNewCar))
//        navigationItem.leftBarButtonItem?.tintColor = .white
//        
//        
//        view.addSubview(carImageView)
//        carImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 350, height: 150)
//        carImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        
//        view.addSubview(carBrandTextField)
//        carBrandTextField.anchor(top: carImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 40)
//        
//        view.addSubview(carModelTextField)
//        carModelTextField.anchor(top: carBrandTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 40)
//        
//        view.addSubview(carBirthTextField)
//        carBirthTextField.anchor(top: carModelTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 40)
//        
//        view.addSubview(carHorsePowerTextField)
//        carHorsePowerTextField.anchor(top: carBirthTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 40)
//        
//        view.addSubview(carCapacityTextField)
//        carCapacityTextField.anchor(top: carHorsePowerTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 40)
//        
//        view.addSubview(carPriceTextField)
//        carPriceTextField.anchor(top: carCapacityTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 40)
//        view.addSubview(carKMPassedTextField)
//        carKMPassedTextField.anchor(top: carPriceTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 40)
//        view.addSubview(carDescTextField)
//        carDescTextField.anchor(top: carKMPassedTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 100)
//
//    }
//}
