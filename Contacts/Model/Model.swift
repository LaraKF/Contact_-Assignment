//
//  ContactsModel.swift
//  Contacts
//
//  Created by Lara K on 22/11/1444 AH.
//

import Foundation

struct Model: Identifiable, Codable {
    var id: String
    var firstName: String
    var lastName: String
    var company: String
    var phone: String
    var email: String
    var url: String
    var address: String
}
