//
//  CarDetailController+TableView.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 5/5/21.
//

import Foundation
import UIKit


extension CarDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        
        let carInfoArray = [detailRealmModel.carBrand, detailRealmModel.carModel, detailRealmModel.carBirth, detailRealmModel.carPower, detailRealmModel.carCapacity, detailRealmModel.carKMPassed, detailRealmModel.carPrice, detailRealmModel.carDesc]

        cell.textLabel!.text = carInfoArray[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 7 {
            return 100
        } else {
            return 40
        }
    }
}
