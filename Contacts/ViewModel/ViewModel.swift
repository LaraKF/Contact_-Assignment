//
//  ViewModel.swift
//  Contacts
//
//  Created by Lara K on 22/11/1444 AH.
//

import Foundation
import FirebaseFirestore


class ViewModel: ObservableObject {
    
    @Published private(set) var model : [Model] = []
    let db = Firestore.firestore()
    
    init() {
        getContacts()
    }
    
    
    
    func getContacts() {
        db.collection("Contacts").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            self.model = documents.map { (queryDocumentSnapshot) -> Model in
                //                do {
                //                    return try document.data(as: Model.self)
                //                } catch {
                //                    print("Error decoding document into Model: \(error)")
                //                    return nil
                //                }
                let data = queryDocumentSnapshot.data()
                
                let id = data["id"] as? String ?? ""
                let firstName = data["firstName"] as? String ?? ""
                let lastName = data["lastName"] as? String ?? ""
                let company = data["company"] as? String ?? ""
                let phone = data["phone"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let url = data["url"] as? String ?? ""
                let address = data["address"] as? String ?? ""
                
                let contacts = Model(id: "\(UUID())", firstName: firstName, lastName: lastName, company: company, phone: phone, email: email, url: url, address: address)
                
                return contacts
            }
        }
    }
    
    func addContact(firstName: String, lastName: String, company: String, phone: String, email: String, url: String, address: String) {
        do {
            let newContact = Model(id: "\(UUID())", firstName: "firstName", lastName: "lastName", company: "company", phone: "phone", email: "email", url: "url", address: "address")
            
            try db.collection("Contacts").document().setData(from: newContact)
        } catch {
            print("Error adding contact to Firesstore: \(error)")
        }
    }
}
