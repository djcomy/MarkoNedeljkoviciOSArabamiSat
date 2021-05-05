//
//  Constants.swift
//  VestelCarShow
//
//  Created by Marko Nedeljkovic on 4/29/21.
//

import Firebase

let url = "https://coding-challenge-bfec1-default-rtdb.europe-west1.firebasedatabase.app"
let DB_REF = Database.database(url: url).reference()
let USERS_REF = DB_REF.child("users")
let FirestoreDB = Firestore.firestore()
let StorageDB = Storage.storage()
