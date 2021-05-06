//
//  HomeController+CollectionView.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 5/3/21.
//

import UIKit

extension HomeController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if Reachability.isConnectedToNetwork() {
            
            return carsViewModel.count
        } else {
            return realmStoredResults.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarCell.identifier, for: indexPath) as! CarCell
        
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        
        
        if Reachability.isConnectedToNetwork() {
            let carsViewModels = carsViewModel[indexPath.row]
            cell.carsViewModel = carsViewModels
            
        } else {
            
            let lists = RealmService.shared.realm.objects(RealmViewModel.self)
            
            let realmViewModel = lists[indexPath.item].carBirth
            
            print("RRR \(realmViewModel)")
            //cell.realmViewModel = realmViewModel
        }
        
        
        return cell
    }
}

extension HomeController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //var indexPath : NSIndexPath = collectionView.indexPathsForSelectedItems
        let dataSource = realmStoredResults[indexPath.row]
        let carDetailController = CarDetailController()
        carDetailController.detailRealmModel = dataSource
        self.navigationController?.pushViewController(carDetailController, animated: true)
        
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForRowAt row: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
