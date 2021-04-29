//
//  ViewController.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 4/29/21.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    
    // MARK: - Properties
    
    var user: User?
    
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
        authenticateUserAndConfigureView()
        let button = UIButton(type: .roundedRect)
                button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
                button.setTitle("Crash", for: [])
                button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
                view.addSubview(button)
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
    
    // MARK: - API
    
    func loadUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).child("username").observeSingleEvent(of: .value) { (snapshot) in
            guard let username = snapshot.value as? String else { return }
            self.welcomeLabel.text = "Welcome, \(username)"
            
            UIView.animate(withDuration: 0.5, animations: {
                self.welcomeLabel.alpha = 1
            })
        }
    }
    
    func authenticateUserAndConfigureView() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let navController = UINavigationController(rootViewController: LoginController())
                navController.modalPresentationStyle = .overCurrentContext
                self.present(navController, animated: true, completion: nil)
            }
        } else {
            configureViewComponents()
            loadUserData()        }
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
        navigationController?.navigationBar.barTintColor = UIColor.mainBlue()
        
        navigationItem.title = "Firebase Login"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_arrow_back_white_24dp"), style: .plain, target: self, action: #selector(handleSignOut))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        view.addSubview(welcomeLabel)
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}


