//
//  SortedMusicViewController.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/11/16.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - SortedMusicViewController

final class SortedMusicViewController: UIViewController {
    
    // MARK: - Reusable Components
    
    private lazy var singerCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.isScrollEnabled = false
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .clear
            $0.delegate = self
            $0.dataSource = self
        }
        
        return collectionView
    }()
    
    private lazy var musicContainerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.isScrollEnabled = true
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .clear
            $0.decelerationRate = .fast
            $0.showsHorizontalScrollIndicator = false
            $0.delegate = self
            $0.dataSource = self
        }
        
        return collectionView
    }()
    
    // MARK: - UI Components
    
    private lazy var containerView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "가수별 모아보기"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 24.adjusted)
    }
    
    // MARK: - Constants
    
    private final let kCategoryItemSpacing = 5.adjusted
    private final let kCategoryInset = UIEdgeInsets(top: 5.adjusted, left: 0, bottom: 5.adjusted, right: 0)
    
    private final let kContainerCellWidth = UIScreen.main.bounds.width - 30.adjusted
    private final let kContainerLineSpacing = 15.adjusted
    private final let kContainerInset = UIEdgeInsets(top: 0, left: 15.adjusted, bottom: 0, right: 15.adjusted)
    
    private final let kMusicCellHeight = 198.adjusted
    private final let kMusicLineSpacing = 10.adjusted
    private final let kMusicItemSpacing = 21.adjusted
    private final let kMusicInset = UIEdgeInsets(top: 14.adjusted, left: 5.adjusted, bottom: 15.adjusted, right: 5.adjusted)
    
    // MARK: - Variables
    
    var musicList: [SortedMusicModel] = SortedMusicModel.sampleData
    var selectedIndex: Int = 0
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        layout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.layer.cornerRadius = 12.adjusted
    }
}

// MARK: - Extensions

extension SortedMusicViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        view.backgroundColor = .white
        [titleLabel, singerCategoryCollectionView, containerView].forEach {
            view.addSubview($0)
        }
        
        containerView.addSubview(musicContainerCollectionView)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(23.adjusted)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(15.adjusted)
        }
        
        singerCategoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12.adjusted)
            $0.leading.equalTo(titleLabel)
            $0.width.equalTo(130.adjusted)
            $0.height.equalTo(28.adjusted)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(singerCategoryCollectionView.snp.bottom).offset(12.adjusted)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        musicContainerCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(calculateContainerViewHeight())
            $0.bottom.lessThanOrEqualToSuperview().offset(-25.adjusted)
        }
    }
    
    private func relayoutGridHeight() {
        musicContainerCollectionView.snp.updateConstraints {
            $0.height.equalTo(calculateContainerViewHeight())
        }
    }
    
    // MARK: - General Helpers
    
    private func register() {
        singerCategoryCollectionView.register(
            SingerCategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: SingerCategoryCollectionViewCell.identifier
        )
        
        musicContainerCollectionView.register(
            MusicContainerCollectionViewCell.self,
            forCellWithReuseIdentifier: MusicContainerCollectionViewCell.identifier
        )
    }
    
    private func calculateCategoryCellWidth(index: Int) -> CGFloat {
        switch index {
        case 0:
            return 31.adjusted
        case 1:
            return 51.adjusted
        case 2:
            return 38.adjusted
        default:
            return 0
        }
    }
    
    private func calculateCategoryViewWidth() -> CGFloat {
        var width: CGFloat = 0
        for i in 0 ..< musicList.count {
            width += calculateCategoryCellWidth(index: i)
        }
        return width
    }
    
    private func calculateContainerViewHeight() -> CGFloat {
        let count: CGFloat = CGFloat(musicList[selectedIndex].musicList.count)
        let heightCount = ceil(count/2)
        return heightCount * kMusicCellHeight + (heightCount - 1) * kMusicLineSpacing + kMusicInset.top + kMusicInset.bottom
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SortedMusicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case singerCategoryCollectionView:
            return CGSize(width: calculateCategoryCellWidth(index: indexPath.item), height: 18.adjusted)
        case musicContainerCollectionView:
            return CGSize(width: kContainerCellWidth, height: calculateContainerViewHeight())
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case singerCategoryCollectionView:
            return kCategoryItemSpacing
        case musicContainerCollectionView:
            return kContainerLineSpacing
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == musicContainerCollectionView {
            return kContainerLineSpacing
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case singerCategoryCollectionView:
            return kCategoryInset
        case musicContainerCollectionView:
            return kContainerInset
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == singerCategoryCollectionView {
            selectedIndex = indexPath.item
            musicContainerCollectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
            relayoutGridHeight()
            collectionView.reloadData()
            musicContainerCollectionView.reloadData()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == musicContainerCollectionView {
            let cellWidthIncludingSpacing = kContainerCellWidth + kContainerLineSpacing

            var offset = targetContentOffset.pointee
            let index = (offset.x + kContainerInset.left) / cellWidthIncludingSpacing
            let roundedIndex = round(index)
            var currentIndex = CGFloat(selectedIndex)
            if currentIndex > roundedIndex {
                currentIndex -= 1
            } else if currentIndex < roundedIndex {
                currentIndex += 1
            }

            offset = CGPoint(
                x: currentIndex * cellWidthIncludingSpacing,
                y: -scrollView.contentInset.top
            )

            targetContentOffset.pointee = offset
            selectedIndex = Int(currentIndex)
            relayoutGridHeight()
            musicContainerCollectionView.reloadData()
            singerCategoryCollectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension SortedMusicViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case singerCategoryCollectionView:
            guard let categoryCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SingerCategoryCollectionViewCell.identifier, for: indexPath)
                    as? SingerCategoryCollectionViewCell else { return UICollectionViewCell() }
            categoryCell.dataBind(singer: musicList[indexPath.item].singer, isSelected: selectedIndex == indexPath.item)
            return categoryCell
            
        case musicContainerCollectionView:
            guard let containerCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MusicContainerCollectionViewCell.identifier, for: indexPath)
                    as? MusicContainerCollectionViewCell else { return UICollectionViewCell() }
            containerCell.dataBind(model: musicList[indexPath.item].musicList)
            return containerCell
            
        default:
            return UICollectionViewCell()
        }
    }
}
