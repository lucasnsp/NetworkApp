//
//  ServiceManager.swift
//  NetworkApp
//
//  Created by Lucas Neves dos santos pompeu on 05/01/24.
//

import Foundation

class ServiceManager {

    static var shared: ServiceManager = ServiceManager()

    private var baseURL: String
    private var requestBuilder: RequestBuilder
    private var session: URLSession = URLSession.shared

    init(baseURL: String? = nil, requestBuilder: RequestBuilder = DefaultRequestBuilder()) {
        self.requestBuilder = requestBuilder
        if let baseURL {
            self.baseURL = baseURL
        } else if let baseURLString = Bundle.main.infoDictionary?["BaseURL"] as? String {
            self.baseURL = baseURLString
        } else {
            self.baseURL = ""
        }
    }



    func request2<T>(with endpoint: Endpoint, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        let urlString = baseURL + endpoint.url

        guard let url: URL = URL(string: urlString) else {
            completion(.failure(.invalidURL(url: urlString)))
            return
        }

        var request = requestBuilder.buildRequest(with: endpoint, url: url)

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
