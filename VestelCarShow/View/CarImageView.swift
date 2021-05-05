//
//  CarImageView.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 5/3/21.
//

import UIKit

class CarImageView: UIImageView {

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        image = UIImage(named: "placeholder")
        layer.backgroundColor = UIColor.blue.cgColor
        layer.cornerRadius = 7.5
        layer.shadowOffset = CGSize(width: -2, height: 2)
        layer.shadowOpacity = 0.5

        contentMode = .scaleAspectFill
        clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
