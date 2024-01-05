//
//  Endpoint.swift
//  NetworkApp
//
//  Created by Lucas Neves dos santos pompeu on 05/01/24.
//

import Foundation

struct Endpoint {
    let url: String
    let method: HTTPMethod
    let headers: [String: String]?
    let parameters: Parameters?
}

enum Parameters {
    case dictionary([String: Any])
    case encodable(Encodable)
}
