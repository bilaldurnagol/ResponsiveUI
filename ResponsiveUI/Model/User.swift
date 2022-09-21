//
//  User.swift
//  ResponsiveUI
//
//  Created by Bilal Durnagöl on 21.09.2022.
//

import Foundation


struct User: Identifiable {
    let id: String = UUID().uuidString
    var name: String
    var image: String
    var title: String
}

var users: [User] = [
    User(name: "Bilal", image: "User1", title: "iOS Developer"),
    User(name: "Şeyma", image: "User2", title: "Teacher"),
    User(name: "Aslan", image: "User3", title: "UI-UX"),
    User(name: "Muhammet", image: "User4", title: "Employee")
]
