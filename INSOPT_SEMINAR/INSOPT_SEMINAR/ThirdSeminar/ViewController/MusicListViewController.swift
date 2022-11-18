//
//  MusicListViewController.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/10/15.
//

import UIKit

import SnapKit
import SwiftyColor

// MARK: - MusicListViewController

final class MusicListViewController: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var musicTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .black.withAlphaComponent(0.1)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - Variables
    
    var musicList: [(MusicModel, Bool)] = [
        (MusicModel(albumImage: "albumImage1", title: "Eleven", singer: "IVE(아이브)"), false),
        (MusicModel(albumImage: "albumImage2", title: "After LIKE", singer: "IVE(아이브)"), false),
        (MusicModel(albumImage: "albumImage3", title: "Attention", singer: "New Jeans"), false),
        (MusicModel(albumImage: "albumImage4", title: "Shut Down", singer: "BLACKPINK"), false),
        (MusicModel(albumImage: "albumImage5", title: "Hype Boy", singer: "New Jeans"), false),
        (MusicModel(albumImage: "albumImage6", title: "LOVE DIVE", singer: "IVE(아이브)"), false),
        (MusicModel(albumImage: "albumImage7", title: "Pink Venom", singer: "BLACKPINK"), false),
        (MusicModel(albumImage: "albumImage8", title: "Rush Hour (feat. j-hope of ...", singer: "Crush"), false),
        (MusicModel(albumImage: "albumImage9", title: "Monologue", singer: "테이"), false),
        (MusicModel(albumImage: "albumImage1", title: "Eleven", singer: "IVE(아이브)"), false),
        (MusicModel(albumImage: "albumImage2", title: "After LIKE", singer: "IVE(아이브)"), false),
        (MusicModel(albumImage: "albumImage3", title: "Attention", singer: "New Jeans"), false),
        (MusicModel(albumImage: "albumImage4", title: "Shut Down", singer: "BLACKPINK"), false),
        (MusicModel(albumImage: "albumImage5", title: "Hype Boy", singer: "New Jeans"), false),
        (MusicModel(albumImage: "albumImage6", title: "LOVE DIVE", singer: "IVE(아이브)"), false),
        (MusicModel(albumImage: "albumImage7", title: "Pink Venom", singer: "BLACKPINK"), false),
        (MusicModel(albumImage: "albumImage8", title: "Rush Hour (feat. j-hope of ...", singer: "Crush"), false),
        (MusicModel(albumImage: "albumImage9", title: "Monologue", singer: "테이"), false),
        (MusicModel(albumImage: "albumImage1", title: "Eleven", singer: "IVE(아이브)"), false),
        (MusicModel(albumImage: "albumImage2", title: "After LIKE", singer: "IVE(아이브)"), false),
        (MusicModel(albumImage: "albumImage3", title: "Attention", singer: "New Jeans"), false),
        (MusicModel(albumImage: "albumImage4", title: "Shut Down", singer: "BLACKPINK"), false),
        (MusicModel(albumImage: "albumImage5", title: "Hype Boy", singer: "New Jeans"), false),
        (MusicModel(albumImage: "albumImage6", title: "LOVE DIVE", singer: "IVE(아이브)"), false),
        (MusicModel(albumImage: "albumImage7", title: "Pink Venom", singer: "BLACKPINK"), false),
        (MusicModel(albumImage: "albumImage8", title: "Rush Hour (feat. j-hope of ...", singer: "Crush"), false),
        (MusicModel(albumImage: "albumImage9", title: "Monologue", singer: "테이"), false)
    ]
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        layout()
    }
}

// MARK: - Extensions

extension MusicListViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        view.backgroundColor = .white
        view.addSubview(musicTableView)
        musicTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(70 * musicList.count + 70)
        }
    }
    
    // MARK: - General Helpers
    
    private func register() {
        musicTableView.register(
            MusicTableViewCell.self,
            forCellReuseIdentifier: MusicTableViewCell.identifier
        )
        
//        musicTableView.register(
//            LargeMusicTableViewCell.self,
//            forCellReuseIdentifier: LargeMusicTableViewCell.identifier
//        )
    }
}

// MARK: - UITableViewDelegate

extension MusicListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /// 첫 번째 셀만 높이 140
        if indexPath.item == 0 {
            return 140
        }
        
        /// 나머지 셀들은 높이 70
        return 70
    }
}

// MARK: - UITableViewDataSource

extension MusicListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// 첫 번쨰 셀만!
        if indexPath.item == 0 {
//            guard let musicCell = tableView.dequeueReusableCell(
//                withIdentifier: LargeMusicTableViewCell.identifier, for: indexPath)
//                    as? LargeMusicTableViewCell else { return UITableViewCell() }
//            musicCell.dataBind(model: musicList[indexPath.row])
//            return musicCell
        }
        
        /// 나머지 셀들!
        guard let musicCell = tableView.dequeueReusableCell(
            withIdentifier: MusicTableViewCell.identifier, for: indexPath)
                as? MusicTableViewCell else { return UITableViewCell() }
        
        musicCell.dataBind(model: musicList[indexPath.row].0, isSelected: musicList[indexPath.row].1)
        return musicCell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        musicList[indexPath.row].1 = !musicList[indexPath.row].1
        tableView.reloadData()
    }
}
