//
//  ViewController.swift
//  NetworkApp
//
//  Created by Lucas Neves dos santos pompeu on 02/01/24.
//

import UIKit

class HomeVC: UIViewController {

    var viewModel: HomeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        viewModel.fetchRequest()
    }


}

