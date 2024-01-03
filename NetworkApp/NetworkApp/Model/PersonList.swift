//
//  PersonList.swift
//  NetworkApp
//
//  Created by Lucas Neves dos santos pompeu on 03/01/24.
//

import Foundation

struct PersonList: Codable {
    var person: [Person]
}

struct Person: Codable {
    var name: String
    var lastName: String
    var phone: String

    enum CodingKeys: String, CodingKey {
        case name = "nome"
        case lastName = "sobrenome"
        case phone = "telefone"
    }
}
