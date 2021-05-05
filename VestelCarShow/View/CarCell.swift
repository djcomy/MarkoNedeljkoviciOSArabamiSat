//
//  CarCell.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 4/30/21.
//

import UIKit

class CarCell: UICollectionViewCell {
    
    public static let identifier = "CarCell"
    
    var carsViewModel: CarsViewModel! {
        didSet{
            guard let url = NSURL(string:carsViewModel.photoURL!) else { return }
            print(url)
            guard let imagedata = NSData.init(contentsOf: url as URL) else { return }
            
            carBrandLabel.text = carsViewModel.carBrand
            carModelLabel.text = carsViewModel.carModel
            carBirthLabel.text = carsViewModel.carBirth
            carImage.image = UIImage(data:imagedata as Data)

        }
    }
    
    
    
    private var carImage: UIImageView = CarImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    
    private var carBrandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.tintColor = .darkGray
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    private var carModelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.tintColor = .darkGray
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    private var carBirthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.tintColor = .darkGray
        label.font = .boldSystemFont(ofSize: 15)
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
        carBrandLabel.topAnchor.constraint(equalTo: carImage.topAnchor, constant: 10).isActive = true
        carBrandLabel.leadingAnchor.constraint(equalTo: carImage.trailingAnchor, constant: 5).isActive = true
        carBrandLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -60).isActive = true
        //carBrandLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(carModelLabel)
        //carModelLabel.topAnchor.constraint(equalTo: carBrandLabel.topAnchor, constant: 10).isActive = true
        carModelLabel.leadingAnchor.constraint(equalTo: carImage.trailingAnchor, constant: 5).isActive = true
        carModelLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -60).isActive = true
        carModelLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(carBirthLabel)
        //carBirthLabel.topAnchor.constraint(equalTo: carModelLabel.topAnchor, constant: 10).isActive = true
        carBirthLabel.leadingAnchor.constraint(equalTo: carImage.trailingAnchor, constant: 5).isActive = true
        carBirthLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -10).isActive = true
        carBirthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }

    func setCellData(_ brand: String, model: String, birth: String , withImage image: UIImage? = nil) {
        carBrandLabel.text = brand
        carModelLabel.text = model
        carBirthLabel.text = birth
        carImage.image = image
    }
}
