//
//  MusicContainerCollectionViewCell.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/11/16.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - MusicContainerCollectionViewCell

final class MusicContainerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Idenifier
    
    static let identifier = "MusicContainerCollectionViewCell"
    
    // MARK: - Reusable Components
    
    private lazy var musicCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Constants
    
    final let kMusicInset: UIEdgeInsets = UIEdgeInsets(top: 14.adjusted, left: 5.adjusted, bottom: 15.adjusted, right: 5.adjusted)
    final let kMusicLineSpacing: CGFloat = 10.adjusted
    final let kMusicInterItemSpacing: CGFloat = 21.adjusted
    final let kCellHeight: CGFloat = 198.adjusted
    
    // MARK: - Variables
    
    var musicList: [MusicModel] = []
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        register()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 12.adjusted
    }
}

// MARK: - Extensions

extension MusicContainerCollectionViewCell {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        backgroundColor = .clear
        contentView.backgroundColor = 0xF1FBF4.color
        contentView.addSubview(musicCollectionView)
        musicCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(calculateCellHeight())
        }
    }
    
    // MARK: - General Helpers
    
    private func register() {
        musicCollectionView.register(
            MusicCollectionViewCell.self,
            forCellWithReuseIdentifier: MusicCollectionViewCell.identifier
        )
    }
    
    private func calculateCellHeight() -> CGFloat {
        let count = CGFloat(musicList.count)
        let heightCount = ceil(count / 2)
        return heightCount * kCellHeight + (heightCount - 1) * kMusicLineSpacing + kMusicInset.top + kMusicInset.bottom
    }
    
    func dataBind(model: [MusicModel]) {
        musicList = model
        musicCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MusicContainerCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 30.adjusted
        let doubleCellWidth = width - kMusicInset.left - kMusicInset.right - kMusicInterItemSpacing
        return CGSize(width: doubleCellWidth / 2 - 1.adjusted , height: 198.adjusted)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return kMusicLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return kMusicInterItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return kMusicInset
    }
}

// MARK: - UICollectionViewDataSource

extension MusicContainerCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let musicCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MusicCollectionViewCell.identifier, for: indexPath)
                as? MusicCollectionViewCell else { return UICollectionViewCell() }
        musicCell.dataBind(model: musicList[indexPath.item])
        return musicCell
    }
}
