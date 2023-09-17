//
//  PhotosCollectionViewController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 11.09.2023.
//

import UIKit

final class PhotosCollectionViewController: UICollectionViewController {

    private let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotosCollectionViewCell.reuseIdentifier)

        // ?what is it?
        collectionView.delegate = self
        collectionView.collectionViewLayout = createLayout()

        configureAppearance()

//        networkService.fetchPhotos(quantity: 5)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotosCollectionViewCell.reuseIdentifier,
            for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.configureCell(photo: UIImage(systemName: "photo") ?? UIImage())
        return cell
    }
}

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: (view.frame.size.width / 2) - 10,
//               height: (view.frame.size.width / 2) - 10)
//    }
}

private extension PhotosCollectionViewController {
    func configureAppearance() {
        title = Strings.TabBar.title(for: .photos)
        collectionView.backgroundColor = Colors.background
        // TODO: make insets in enum
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
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

    // MARK: - Apply Snapshot
    func applySnapshot() {
//        let snapshot =
    }

    // MARK: - Configure DataSource
    func configureDataSource()  {

    }

    // MARK: - Make Snapshot
    func makeSnapshot() {

    }
}
