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

    func getPersonList(completion: @escaping (Result<PersonList,NetworkError>) -> Void) {
        let urlString: String = "https://run.mocky.io/v3/06e0a58e-acac-41d4-8a5a-6e6be756364c"

        guard let url: URL = URL(string: urlString) else {
            completion(.failure(.invalidURL(url: urlString)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error {
                print("ERROR \(#function) Detalhe do error: \(error.localizedDescription)")
                completion(.failure(.networkFailure(error)))
                return
            }

            guard let data else {
                completion(.failure(.noData))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let personList: PersonList = try JSONDecoder().decode(PersonList.self, from: data)
                print("SUCCESS -> \(#function)")
                completion(.success(personList))
            } catch  {
                print("ERROR -> \(#function)")
                completion(.failure(.decodingFailure(error)))
            }
        }
        task.resume()
    }

}
