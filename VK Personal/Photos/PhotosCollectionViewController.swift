//
//  PhotosCollectionViewController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 11.09.2023.
//

import UIKit

final class PhotosCollectionViewController: UICollectionViewController {

    private var photos = [Photo]()

    private let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAppearance()

        showIndicator()

        collectionView.delegate = self
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(PhotosCollectionViewCell.self,
                                forCellWithReuseIdentifier: PhotosCollectionViewCell.reuseIdentifier)

        networkService.getPhotos(quantity: 10) { [weak self] photos in
            self?.photos = photos
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.hideIndicator()
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotosCollectionViewCell.reuseIdentifier,
            for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.configureCell(photo: photos[indexPath.row])
        return cell
    }
}

extension PhotosCollectionViewController {
    // MARK: - Create Layout
    func createLayout() -> UICollectionViewLayout {
        let edgeSpacing = NSDirectionalEdgeInsets(top: 0,
                                                  leading: 16,
                                                  bottom: 24,
                                                  trailing: 16)
        let spacing: CGFloat = 16


        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/2),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: size)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(163))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = edgeSpacing
        section.interGroupSpacing = spacing

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
}

private extension PhotosCollectionViewController {
    func configureAppearance() {
        title = Strings.TabBar.title(for: .photos)
        collectionView.backgroundColor = .mainBackground
        // TODO: make insets in enum
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
}
