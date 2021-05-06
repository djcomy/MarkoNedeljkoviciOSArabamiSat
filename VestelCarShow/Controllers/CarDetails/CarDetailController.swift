//
//  FetchingServise.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 5/4/21.
//


import UIKit
import Firebase
import RealmSwift

struct CarInfo {
    let carInfoType: String?
    
}

class CarDetailController: UIViewController {
    
    let realm = try! Realm()
    
    var detailModel = CarsViewModel(car: Car(carBrand: "carBrand", carModel: "carModel", carBirth: "carBirth", carPower: "carPower", carCapacity: "carCapacity", carPrice: "carPrice", carKMPassed: "carKMPassed", carDesc: "carDesc", photoURL: "photoUrl"))
    
    var detailRealmModel = RealmViewModel()

    var tableView = UITableView()
    
    lazy var carImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    lazy var carDetailMainLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Car Details"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        
        setCarPhoto()
        setupTableView()
    }
    
    func setCarPhoto(){
        
        if Reachability.isConnectedToNetwork() {
            guard let url = NSURL(string:detailModel.photoURL!) else { return }
            print(url)
            guard let imagedata = NSData.init(contentsOf: url as URL) else { return }
            self.carImageView.image = UIImage(data:imagedata as Data)
            
        } else {
            guard let url = NSURL(string:detailRealmModel.photoUrl!) else { return }
            print(url)
            guard let imagedata = NSData.init(contentsOf: url as URL) else { return }
            self.carImageView.image = UIImage(data:imagedata as Data)
            
        }
    }
    
    fileprivate func setupTableView() {
        
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor.white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.separatorColor = .darkGray
        tableView.separatorStyle = .singleLine
        tableView.estimatedRowHeight = 60
        tableView.backgroundColor = UIColor.white
        tableView.isEmptyRowsHidden = true
    }
    
    @objc func getBackToMainController() {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func configureViewComponents() {
        let navBar = navigationController?.navigationBar
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.barStyle = .black
        navBar!.barTintColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        navigationItem.title = "Car Details"
        navBar!.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.75
        navigationController?.navigationBar.layer.shadowOffset = .zero
        navigationController?.navigationBar.layer.shadowRadius = 2
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_arrow_back_white_24dp"), style: .plain, target: self, action: #selector(getBackToMainController))
        navigationItem.leftBarButtonItem?.tintColor = .darkGray
        
        
        view.addSubview(carImageView)
        carImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.bounds.width, height: 200)
        carImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addSubview(carDetailMainLabel)
        carDetailMainLabel.anchor(top: carImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 32, width: 0, height: 40)
        carDetailMainLabel.centerXAnchor.constraint(equalTo: carImageView.centerXAnchor).isActive = true
        
        view.addSubview(tableView)
        tableView.anchor(top: carDetailMainLabel.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 0)
        
    }
}
