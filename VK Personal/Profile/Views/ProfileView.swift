//
//  ProfileView.swift
//  VK Personal
//
//  Created by Олег Алексеев on 19.09.2023.
//

import UIKit
import OSLog

final class ProfileView: VKBaseView {

    let logger = Logger(subsystem: "VKPersonal", category: "ProfileView")

    private let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 100
        imageView.backgroundColor = .separatorVK
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .text
        label.textAlignment = .center
        return label
    }()

    private let stackViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 16
        return stackView
    }()

    func configure(account: Account) {
        nameLabel.text = account.fullName
        guard let photoData = account.photoData else { return }
        photoView.image = UIImage(data: photoData)
    }
}

extension ProfileView {
    override func configureView() {
        super.configureView()

    }

    override func addSubviews() {
        super.addSubviews()

        stackViewContainer.addArrangedSubview(photoView)
        stackViewContainer.addArrangedSubview(nameLabel)

        setupView(stackViewContainer)
    }

    override func setupLayout() {
        super.setupLayout()

        NSLayoutConstraint.activate([
            photoView.heightAnchor.constraint(equalToConstant: 200),
            photoView.widthAnchor.constraint(equalTo: photoView.heightAnchor),

            stackViewContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackViewContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 54),
            stackViewContainer.heightAnchor.constraint(equalTo: stackViewContainer.heightAnchor)
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .mainBackground
    }
}
