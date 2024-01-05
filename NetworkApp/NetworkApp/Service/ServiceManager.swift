//
//  ServiceManager.swift
//  NetworkApp
//
//  Created by Lucas Neves dos santos pompeu on 05/01/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NetworkLayer {
    var session: URLSession { get }
    func request<T: Decodable>(with urlString: String, method: HTTPMethod, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class ServiceManager: NetworkLayer {

    static var shared: ServiceManager = ServiceManager()

    var session: URLSession = URLSession.shared

    func request<T>(with urlString: String, method: HTTPMethod = .get, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {

        guard let url: URL = URL(string: urlString) else {
            completion(.failure(.invalidURL(url: urlString)))
            return
        }

        var request  = URLRequest(url: url)
        request.httpMethod = method.rawValue

        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error {
                    print("ERROR \(#function) Detalhe do error: \(error.localizedDescription)")
                    completion(.failure(.networkFailure(error)))
                    return
                }

                guard let data else {
                    completion(.failure(.noData))
                    return
                }

                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let object: T = try decoder.decode(T.self, from: data)
                    print("SUCCESS -> \(#function)")
                    completion(.success(object))
                } catch  {
                    print("ERROR -> \(#function)")
                    completion(.failure(.decodingFailure(error)))
                }
            }
        }
        task.resume()
    }


}
