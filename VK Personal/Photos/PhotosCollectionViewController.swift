//
//  PhotosCollectionViewController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 11.09.2023.
//

import UIKit

final class PhotosCollectionViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotosCollectionViewCell.reuseIdentifier)

        collectionView.delegate = self

        configureAppearance()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (view.frame.size.width / 2) - 10,
               height: (view.frame.size.width / 2) - 10)
    }
}

private extension PhotosCollectionViewController {
    func configureAppearance() {
        title = Strings.TabBar.title(for: .photos)
        collectionView.backgroundColor = Colors.mainBackground
    }
}
