//
//  MusicGridViewController.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/10/15.
//

import UIKit

import Moya
import SnapKit
import SwiftyColor
import Then

// MARK: - MusicGridViewController

final class MusicGridViewController: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var musicCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Variables
    
    let exampleProvider = MoyaProvider<ExampleRouter>(
        plugins: [NetworkLoggerPlugin(verbose: true)]
    )

    var musicList: [MusicModel] = []
    
    // MARK: - Constants
    
    final let kMusicInset: UIEdgeInsets = UIEdgeInsets(top: 49, left: 20, bottom: 10, right: 20)
    final let kMusicLineSpacing: CGFloat = 10
    final let kMusicInterItemSpacing: CGFloat = 21
    final let kCellHeight: CGFloat = 198
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMusicList()
    }
}

// MARK: - Extensions

extension MusicGridViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        view.backgroundColor = .white
        view.addSubview(musicCollectionView)
        musicCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
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
        let heightCount = count / 2 + count.truncatingRemainder(dividingBy: 2)
        return heightCount * kCellHeight + (heightCount - 1) * kMusicLineSpacing + kMusicInset.top + kMusicInset.bottom
    }
    
    // MARK: - Server Helpers
    
    private func fetchMusicList() {
        exampleProvider.request(.fetchSongs) { response in
            switch response {
            case .success(let result):
                let status = result.statusCode
                if status >= 200 && status < 300 {
                    do {
                        let response = try result.map(FetchMusicResponseDto.self)
                        for dto in response.data {
                            self.musicList.append(dto.convertToMusic())
                        }
                        self.musicCollectionView.reloadData()
                    }
                    catch(let error) {
                        print(error.localizedDescription)
                    }
                }
                if status >= 400 {
                    print("error")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MusicGridViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let doubleCellWidth = width - kMusicInset.left - kMusicInset.right - kMusicInterItemSpacing
        return CGSize(width: doubleCellWidth / 2, height: 198)
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

// MARK: -UICollectionViewDataSource

extension MusicGridViewController: UICollectionViewDataSource {
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
