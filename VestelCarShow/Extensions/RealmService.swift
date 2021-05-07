//
//  RealmService.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 5/5/21.
//

import Foundation
import RealmSwift

class RealmService {
    
    private init() {}
    static let shared = RealmService()
    
    lazy var realm:Realm = {
        return try! Realm()
    }()
    
    func create<T: Object>(_ object: T) {
        do{
            try realm.write{
                realm.add(object, update: Realm.UpdatePolicy.modified)
            }
        } catch {
            post(error)
        }
    }
    
    func add<P: Object, T: Object>(_ person: P, object: T) {
        do{
            realm.add(object, update: Realm.UpdatePolicy.modified)
        }
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
        do{
            try realm.write{
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            post(error)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do{
            try realm.write{
                realm.delete(object)
            }
        } catch {
            post(error)
        }
    }
    
    func post(_ error: Error) {
        NotificationCenter.default.post(name: NSNotification.Name("RealmError"), object: error)
    }
    
    func observeRealmErrors(in vc: UIViewController, completion: @escaping (Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("RealmError"),
                                               object: nil,
                                               queue: nil) { (notification) in
            completion(notification.object as? Error)
        }
    }
    
    func stopObservingErrors(in vc: UIViewController){
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("RealmError"), object: nil)
    }
}
