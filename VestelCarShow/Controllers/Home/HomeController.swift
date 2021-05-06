//
//  ViewController.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 4/29/21.
//

import UIKit
import Firebase
import RealmSwift

class HomeController: UIViewController {
    
    let myPrimaryKey = Person.primaryKey()
    var person = Person()
    // MARK: - Properties
    var pictures = [UIImage]()
    var cars = [Car]()
    var realmStoredResults: Results<RealmViewModel>!
    private var itemsToken: NotificationToken?
    var carsViewModel = [CarsViewModel]()
    var realmViewModel = [RealmViewModel]()
    weak var collectionView: UICollectionView!
    
    override func loadView() {
        super.loadView()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ])
        self.collectionView = collectionView
    }
    
    var welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0
        return label
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        if Reachability.isConnectedToNetwork(){
            DispatchQueue.main.async {
              self.loadUserData()
                
            }
        }
        let realm = RealmService.shared.realm
        let specificPerson = realm.object(ofType: Person.self, forPrimaryKey: myPrimaryKey)
        print(Realm.Configuration.defaultConfiguration.fileURL)
        realmStoredResults = RealmViewModel.all()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(CarCell.self, forCellWithReuseIdentifier: "CarCell")
        self.collectionView.register(RealmCell.self, forCellWithReuseIdentifier: "RealmCell")
        self.collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor.white
        authenticateUserAndConfigureView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        
        
        self.itemsToken = self.realmStoredResults?.observe { [weak self] (changes: RealmCollectionChange) in
                  DispatchQueue.main.async {
                    self!.collectionView.reloadData()
                  }
              }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      itemsToken?.invalidate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    // MARK: - Selectors
    
    @objc func handleSignOut() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
            self.signOut()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func addNewCar() {
        
        let newCarController = AddNewCarController()
        self.navigationController?.pushViewController(newCarController, animated: true)
        
    }
    
    func authenticateUserAndConfigureView() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let navController = UINavigationController(rootViewController: LoginController())
                navController.modalPresentationStyle = .overCurrentContext
                self.present(navController, animated: true, completion: nil)
            }
        } else {
            configureViewComponents()
            
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            let navController = UINavigationController(rootViewController: LoginController())
            navController.modalPresentationStyle = .overCurrentContext
            navController.navigationBar.barStyle = .black
            self.present(navController, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print("Error signing out: ", signOutError)
        }
    }
    
    // MARK: - Helper Functions
    
    func configureViewComponents() {
        let navBar = navigationController?.navigationBar
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.barStyle = .black
        navBar!.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        navBar!.barTintColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.75
        navigationController?.navigationBar.layer.shadowOffset = .zero
        navigationController?.navigationBar.layer.shadowRadius = 2
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_arrow_back_white_24dp"), style: .plain, target: self, action: #selector(handleSignOut))
        navigationItem.leftBarButtonItem?.tintColor = .darkGray
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_add_back_white_24dp"), style: .plain, target: self, action: #selector(addNewCar))
        navigationItem.rightBarButtonItem?.tintColor = .darkGray
        
        view.addSubview(welcomeLabel)
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}



