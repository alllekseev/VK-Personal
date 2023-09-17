//
//  FriendsTableViewCell.swift
//  VK Personal
//
//  Created by Олег Алексеев on 13.09.2023.
//

import UIKit

final class FriendsTableViewCell: UITableViewCell {

    static let reuseIdentifier = "FriendsTableViewCell"

    private let photoView = PhotoView(frame: .zero)

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.text
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()

    private let stackViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        photoView.image = nil
    }

    func configureCell(name: String) {
        nameLabel.text = name
    }
}

extension FriendsTableViewCell: BaseViewProtocol {
    func configureView() {
        addSubviews()
        setupLayout()
        configureAppearance()
    }

    func addSubviews() {
        stackViewContainer.addArrangedSubview(photoView)
        stackViewContainer.addArrangedSubview(nameLabel)

        setupView(stackViewContainer)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            stackViewContainer.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            stackViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }

    func configureAppearance() {

        backgroundColor = Colors.white
    }


}
