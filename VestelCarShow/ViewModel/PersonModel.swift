//
//  RealmUser.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 5/6/21.
//

import Foundation
import RealmSwift

class Person: Object {
    
    @objc dynamic var personID = uid
    @objc dynamic var name = ""
    
    let cars = List<RealmViewModel>()
    
    override static func primaryKey() -> String? {
        return "personID"
    }
}
