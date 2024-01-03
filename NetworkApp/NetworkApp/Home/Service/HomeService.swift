//
//  HomeService.swift
//  NetworkApp
//
//  Created by Lucas Neves dos santos pompeu on 02/01/24.
//

import Foundation

class HomeService {

    func getPersonList() {
        let urlString: String = "https://run.mocky.io/v3/06e0a58e-acac-41d4-8a5a-6e6be756364c"

        guard let url: URL = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error {
                print("ERROR \(#function) Detalhe do error: \(error.localizedDescription)")
                return
            }

            guard let data else {

                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }

//            do {
//                try <#throwing expression#>
//            } catch <#pattern#> {
//                <#statements#>
//            }
        }
        task.resume()
    }

}
