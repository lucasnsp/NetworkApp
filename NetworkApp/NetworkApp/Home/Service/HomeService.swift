//
//  HomeService.swift
//  NetworkApp
//
//  Created by Lucas Neves dos santos pompeu on 02/01/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL(url: String)
    case noData
    case invalidResponse
    case decodingFailure(Error)
    case networkFailure(Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return "URL inválida -> \(url)"
        case .noData:
            return "Dados não recebidos da API."
        case .invalidResponse:
            return "Resposta inváida da API."
        case .decodingFailure(let error):
            return "Decodificação falhou: \(error.localizedDescription)"
        case .networkFailure(let error):
            return "Falha na rede: \(error.localizedDescription)"
        }
    }
}

class HomeService {

    func getPersonList(completion: @escaping (Result<[Person],NetworkError>) -> Void) {
        let urlString: String = "https://run.mocky.io/v3/06e0a58e-acac-41d4-8a5a-6e6be756364c"

        ServiceManager.shared.request(with: urlString, method: .get, decodeType: PersonList.self) { result in
            switch result {
            case .success(let success):
                completion(.success(success.person))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

}
