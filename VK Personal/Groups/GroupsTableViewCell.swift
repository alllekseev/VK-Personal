//
//  GroupsTableViewCell.swift
//  VK Personal
//
//  Created by Олег Алексеев on 13.09.2023.
//

import UIKit

final class GroupsTableViewCell: UITableViewCell {

    static let reuseIdentifier = "GroupsTableViewCell"

    private let photoView = PhotoView(frame: .zero)

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.text
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.textPlaceholder
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        return label
    }()

    private let stackViewLabels: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        return stackView
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
        descriptionLabel.text = nil
    }

    func configureCell(name: String, description: String) {
        nameLabel.text = name
        descriptionLabel.text = description
    }
}

extension GroupsTableViewCell: BaseViewProtocol {
    func configureView() {
        addSubviews()
        setupLayout()
        configureAppearance()
    }

    func addSubviews() {
        stackViewLabels.addArrangedSubview(nameLabel)
        stackViewLabels.addArrangedSubview(descriptionLabel)

        stackViewContainer.addArrangedSubview(photoView)
        stackViewContainer.addArrangedSubview(stackViewLabels)

        setupView(stackViewContainer)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            stackViewContainer.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            stackViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }

    func configureAppearance() {
        backgroundColor = Colors.white
    }
}
