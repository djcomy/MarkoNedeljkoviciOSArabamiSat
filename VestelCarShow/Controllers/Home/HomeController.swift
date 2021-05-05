//
//  ViewController.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 4/29/21.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    //
    // MARK: - Properties
    var pictures = [UIImage]()
    var cars = [Car]()
    var carsViewModel = [CarsViewModel]()
    //var user: User?
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
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(CarCell.self, forCellWithReuseIdentifier: "CarCell")
        self.collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor.white
        authenticateUserAndConfigureView()
        
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
        button.setTitle("Crash", for: [])
        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(button)
        //getImage()
    }
    
    @IBAction func crashButtonTapped(_ sender: AnyObject) {
        fatalError()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
            loadUserData()
            
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
        view.backgroundColor = UIColor.googleLightGray()
        navigationController?.navigationBar.barTintColor = UIColor.lightGray

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_arrow_back_white_24dp"), style: .plain, target: self, action: #selector(handleSignOut))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_arrow_back_white_24dp"), style: .plain, target: self, action: #selector(addNewCar))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        view.addSubview(welcomeLabel)
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension HomeController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return carsViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarCell.identifier, for: indexPath) as! CarCell
        
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = .zero
        cell.layer.shadowRadius = 2
        
        let carsViewModels = carsViewModel[indexPath.row]
        cell.carsViewModel = carsViewModels
        
        return cell
    }
}

