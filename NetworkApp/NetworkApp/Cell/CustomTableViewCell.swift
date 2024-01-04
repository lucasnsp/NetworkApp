//
//  HomeTableViewCell.swift
//  Projeto-network
//
//  Created by Caio F on 14/07/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier: String = "CustomTableViewCell"

    lazy var screen: CustomTableViewCellScreen = {
        let view = CustomTableViewCellScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubView()
        setupConstraints()
    }
    
    private func addSubView() {
        contentView.addSubview(screen)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            screen.topAnchor.constraint(equalTo: contentView.topAnchor),
            screen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            screen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            screen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func setupHomeCell(data: Person) {
        screen.nameLabel.text = "Nome: \(data.name)"
        screen.surnameLabel.text = "Sobrenome: \(data.lastName)"
        screen.phoneLabel.text = "Telefone: \(data.phone)"
    }
}
