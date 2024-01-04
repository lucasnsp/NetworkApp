//
//  CustomTableViewCellScreen.swift
//  Projeto-network
//
//  Created by Caio F on 14/07/23.
//

import UIKit

class CustomTableViewCellScreen: UIView {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var surnameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSuperView()
        setupConstraints()
    }
    
    private func configSuperView() {
        addSubview(nameLabel)
        addSubview(surnameLabel)
        addSubview(phoneLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            surnameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            surnameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            surnameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            phoneLabel.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 10),
            phoneLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            phoneLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
