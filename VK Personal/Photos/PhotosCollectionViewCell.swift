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

    func configureCell(photo: Photo) {
        photo.sizes.enumerated().forEach { (index, size) in
            if size.type == PhotoType.m.rawValue,
               let data = size.photoData {
                photoView.image = UIImage(data: data)
            }
        }
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
            photoView.topAnchor.constraint(equalTo: topAnchor),
            photoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoView.bottomAnchor.constraint(equalTo: bottomAnchor),
            photoView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    func configureAppearance() {
        backgroundColor = Colors.white
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }


}
