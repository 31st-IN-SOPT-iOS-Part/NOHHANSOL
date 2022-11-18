//
//  PhotoGridViewController.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/10/22.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - PhotoGridViewController

final class PhotoGridViewController: UIViewController {

    // MARK: - Reusable Components
    
    private lazy var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
        }
        lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.isScrollEnabled = true
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .clear
            $0.delegate = self
            $0.dataSource = self
        }
        return collectionView
    }()
    
    // MARK: - UI Components
    
    private let topView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "최근 항목"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    private lazy var closeButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "iconClose"), for: .normal)
    }
    
    private lazy var sendButton = UIButton()
    private let sendLabel = UILabel().then {
        $0.text = "전송"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14.adjusted, weight: .regular)
    }
    
    private let countLabel = UILabel().then {
        $0.textColor = 0xF6DD2A.color
        $0.font = .systemFont(ofSize: 14.adjusted, weight: .regular)
    }
    
    // MARK: - Variables
    
    var count: Int = 0
    var imageList: [(String, Int)] = [
        ("galleryImage1", 0),
        ("galleryImage2", 0),
        ("galleryImage3", 0),
        ("galleryImage4", 0),
        ("galleryImage5", 0),
        ("galleryImage6", 0),
        ("galleryImage7", 0),
        ("galleryImage8", 0),
        ("galleryImage9", 0),
        ("galleryImage10", 0),
        ("galleryImage11", 0),
        ("galleryImage12", 0),
        ("galleryImage13", 0),
        ("galleryImage14", 0),
        ("galleryImage15", 0),
        ("galleryImage16", 0),
        ("galleryImage17", 0),
        ("galleryImage18", 0),
        ("galleryImage19", 0),
        ("galleryImage20", 0),
        ("galleryImage21", 0),
        ("galleryImage22", 0),
        ("galleryImage23", 0)
        ]
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        layout()
    }
}

// MARK: - Extensions

extension PhotoGridViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        view.backgroundColor = .white
        
        [topView, photoCollectionView].forEach {
            view.addSubview($0)
        }
        
        [closeButton, titleLabel, sendButton].forEach {
            topView.addSubview($0)
        }
        
        [sendLabel, countLabel].forEach {
            sendButton.addSubview($0)
        }
        
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(38.adjusted)
        }
        
        closeButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(12.adjusted)
            $0.width.height.equalTo(24.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        
        sendButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10.adjusted)
            $0.width.equalTo(34.adjusted)
            $0.height.equalTo(16.adjusted)
        }
        
        sendLabel.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(sendLabel.snp.leading).offset(-4.adjusted)
        }
        
        photoCollectionView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - General Helpers
    
    private func register() {
        photoCollectionView.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier
        )
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotoGridViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 18.adjusted) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9.adjusted
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7.adjusted
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3.adjusted, left: 0, bottom: 10.adjusted, right: 0)
    }
}

// MARK: - UICollectionViewDataSource

extension PhotoGridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let photoCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath)
                as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        if indexPath.item == 0 {
            photoCell.dataBind(imageName: nil, count: 0)
        } else {
            photoCell.dataBind(imageName: imageList[indexPath.item-1].0, count: imageList[indexPath.item-1].1)
        }
        return photoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item != 0 {
            if imageList[indexPath.item - 1].1 == 0 {
                count += 1
                imageList[indexPath.item - 1].1 = count
            } else {
                count -= 1
                let standardCount = imageList[indexPath.item - 1].1
                imageList[indexPath.item - 1].1 = 0
                for i in 0..<imageList.count {
                    if imageList[i].1 > standardCount {
                        imageList[i].1 -= 1
                    }
                }
            }
            countLabel.text = "\(count)"
            collectionView.reloadData()
        }
    }
}
