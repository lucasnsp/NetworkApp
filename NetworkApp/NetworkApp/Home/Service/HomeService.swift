//
//  HomeService.swift
//  NetworkApp
//
//  Created by Lucas Neves dos santos pompeu on 02/01/24.
//

import Foundation

class HomeService {

    func getPersonList(completion: @escaping (Result<[Person],NetworkError>) -> Void) {
        let urlString: String = "06e0a58e-acac-41d4-8a5a-6e6be756364c"
        let endpoint = Endpoint(url: urlString)

        ServiceManager.shared.request2(with: endpoint, decodeType: PersonList.self) { result in
            switch result {
            case .success(let success):
                completion(.success(success.person))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

}
