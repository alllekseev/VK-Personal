//
//  PhotosCollectionViewCell.swift
//  VK Personal
//
//  Created by Олег Алексеев on 13.09.2023.
//

import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PhotosCollectionViewCell"

    private let photoView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photoView.image = nil
    }

    func configureCell(photo: UIImage) {
        photoView.image = photo
    }
}

extension PhotosCollectionViewCell: BaseViewProtocol {
    func configureView() {
        addSubviews()
        setupLayout()
        configureAppearance()
    }

    func addSubviews() {
        setupView(photoView)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            photoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            photoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            photoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }

    func configureAppearance() {
        backgroundColor = Colors.white
        layer.cornerRadius = 20
    }


}
