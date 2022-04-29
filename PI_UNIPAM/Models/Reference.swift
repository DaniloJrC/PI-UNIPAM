//
//  Reference.swift
//  PIUNIPAM
//
//  Created by Danilo Constancio on 24/04/22.
//

import FirebaseAuth

import UIKit
import FirebaseDatabase
import FirebaseFirestore
import FirebaseStorage

final class Reference {
    static var currentUser: FirebaseAuth.User? {
        Auth.auth().currentUser
    }
    
    static var userID: String { currentUser?.uid ?? "" }
    static var randomId: String { Database.database().reference().childByAutoId().key! }
    static var userPath: DocumentReference { Firestore.firestore().collection("Users").document(userID) }
    static var author: CollectionReference { Firestore.firestore().collection("Author") }
    static var articles: CollectionReference { Firestore.firestore().collection("Articles") }
    static var storageUserPath: StorageReference { Storage.storage().reference().child("Users").child(userID) }
    static var profileImage: StorageReference { storageUserPath.child("ProfileImage").child("profileImage.jpeg") }
}
