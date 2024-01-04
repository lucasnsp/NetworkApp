//
//  HomeViewModel.swift
//  NetworkApp
//
//  Created by Lucas Neves dos santos pompeu on 02/01/24.
//

import Foundation

class HomeViewModel {

    var service: HomeService = HomeService()

    public func fetchRequest() {
        service.getPersonList { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.errorDescription ?? "")
            }
        }
    }
}
