//
//  RealmCell.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 5/6/21.
//

import UIKit
import RealmSwift

class RealmCell: UICollectionViewCell {
    
    public static let identifier = "RealmCell"
    let realm = try! Realm()
   // private var model: RealmViewModel?

    var realmViewModel: RealmViewModel? {
        didSet{
            
           // guard let url = NSURL(string:realmViewModel!.photoUrl!) else { return }
          //  guard NSData.init(contentsOf: url as URL) != nil else { return }
            
            carBrandLabel.text = realmViewModel!.carBrand
            carModelLabel.text = realmViewModel!.carModel
            carBirthLabel.text = realmViewModel!.carBirth
            ///carImage.image = UIImage(data:imagedata as Data)
        }
    }

        private var carImage: UIImageView = CarImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        
        private var carBrandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 35)
        return label
        }()
        private var carModelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 25)
        return label
        }()
        private var carBirthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 20)
        return label
        }()
        
        override init (frame: CGRect) {
        super.init(frame: frame)
        
        configureViewComponents()
        }
        
        required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        }
        
        private func configureViewComponents() {
        
        addSubview(carImage)
        carImage.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        carImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        carImage.widthAnchor.constraint(equalTo: heightAnchor, constant: -5).isActive = true
        carImage.heightAnchor.constraint(equalTo: heightAnchor, constant: -10).isActive = true
        
        addSubview(carBrandLabel)
        carBrandLabel.topAnchor.constraint(equalTo: carImage.topAnchor, constant: 5).isActive = true
        carBrandLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 70).isActive = true
        
        addSubview(carModelLabel)
        carModelLabel.topAnchor.constraint(equalTo: carBrandLabel.bottomAnchor, constant: 15).isActive = true
        carModelLabel.leadingAnchor.constraint(equalTo: carImage.trailingAnchor, constant: 5).isActive = true
        carModelLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -50).isActive = true
        carModelLabel.centerXAnchor.constraint(equalTo: carBrandLabel.centerXAnchor).isActive = true
        
        addSubview(carBirthLabel)
        carBirthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        carBirthLabel.centerXAnchor.constraint(equalTo: carBrandLabel.centerXAnchor).isActive = true
        }
        
        func setCellData(_ brand: String, model: String, birth: String , withImage image: UIImage? = nil) {
        carBrandLabel.text = brand
        carModelLabel.text = model
        carBirthLabel.text = birth
        carImage.image = image
        }
    }

