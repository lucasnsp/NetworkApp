//
//  NetworkLogger.swift
//  NetworkApp
//
//  Created by Lucas Neves dos santos pompeu on 06/01/24.
//

import Foundation

struct NetworkLogger {

    static func log(request: URLRequest?, response: URLResponse?, data: Data?, error: Error?, verbose: Bool = true) {
        print("--------- 🚀 START OF REQUEST 🚀 ---------")

        if let url = request?.url {
            print("Request URL: \(url.absoluteString)")
        }

        if let httpMethod = request?.httpMethod {
            print("HTTP Method: \(httpMethod)")
        }

        if verbose, let headers = request?.allHTTPHeaderFields {
            print("Headers: \(headers)")
        }

        if verbose, let body = request?.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("Body Request: \(bodyString)")
        }

        if let httpResponse = response as? HTTPURLResponse {
            let statusCode = httpResponse.statusCode
            let statusIcon = (200...299).contains(statusCode) ? "✅" : "❌"
            print("Status Code: \(statusCode) \(statusIcon)")
        } else if let error {
            print("🔴 Error: \(error.localizedDescription)")
        } else {
            print("🔴 Error: No Response and No Error")
        }

        if verbose, let headers = (response as? HTTPURLResponse)?.allHeaderFields as? [String: Any] {
            print("Response Headers: \(headers)")
        }

        if let data = data {
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)

                if let jsonStr = String(data: jsonData, encoding: .utf8) {
                    print("JSON Response: ⬇️\n\(jsonStr)")
                }
            } catch let serializationError {
                print("Failed to serialize JSON: \(serializationError)")
            }
        }

        print("------------- END OF REQUEST -------------\n")
    }

    static func logError(error: NetworkError) {
        print("--------- ❌ START OF ERROR ❌ ---------")
        print("Error: \(error.errorDescription ?? "")")
        print("------------- END OF ERROR -------------\n")
    }
}
