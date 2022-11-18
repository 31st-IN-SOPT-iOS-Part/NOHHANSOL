//
//  FriendListViewController.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/10/22.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - FriendListViewController

final class FriendListViewController: UIViewController {

    // MARK: - Reusable Components
    
    private lazy var friendListTableView: UITableView = {
        lazy var tableView = UITableView(frame: .zero, style: .plain).then {
            $0.isScrollEnabled = true
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .clear
            $0.delegate = self
            $0.dataSource = self
            $0.separatorStyle = .none
        }
        return tableView
    }()
    
    // MARK: - UI Components
    
    private let topView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "친구"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 22.adjusted, weight: .medium)
    }
    
    private lazy var settingButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "iconSetting"), for: .normal)
    }
    
    // MARK: - Variables
    
    var pinnedFriendList: [KakaoFriendModel] = []
    
    var friendList: [KakaoFriendModel] = [
        KakaoFriendModel(profileImage: "profileImage1", name: "안솝트", message: "언제 볼건데??"),
        KakaoFriendModel(profileImage: "profileImage2", name: "최솝트", message: "언제 볼건데??"),
        KakaoFriendModel(profileImage: "profileImage3", name: "정솝트", message: "언제 볼건데??"),
        KakaoFriendModel(profileImage: "profileImage4", name: "강솝트", message: "언제 볼건데??"),
        KakaoFriendModel(profileImage: "profileImage5", name: "오솝트", message: "언제 볼건데??"),
        KakaoFriendModel(profileImage: "profileImage6", name: "황솝트", message: "언제 볼건데??"),
        KakaoFriendModel(profileImage: "profileImage7", name: "최솝트", message: "언제 볼건데??"),
        KakaoFriendModel(profileImage: "profileImage8", name: "고솝트", message: "언제 볼건데??"),
        KakaoFriendModel(profileImage: "profileImage9", name: "하솝트", message: "언제 볼건데??"),
        KakaoFriendModel(profileImage: "profileImage9", name: "하솝트", message: "언제 볼건데??"),
        KakaoFriendModel(profileImage: "profileImage9", name: "하솝트", message: "언제 볼건데??"),
        KakaoFriendModel(profileImage: "profileImage9", name: "하솝트", message: "언제 볼건데??"),
        KakaoFriendModel(profileImage: "profileImage9", name: "하솝트", message: "언제 볼건데??"),
        KakaoFriendModel(profileImage: "profileImage9", name: "하솝트", message: "언제 볼건데??"),
        KakaoFriendModel(profileImage: "profileImage9", name: "하솝트", message: "언제 볼건데??")
    ]
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        layout()
    }
}

// MARK: - Extensions

extension FriendListViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        view.backgroundColor = .white
        [topView, friendListTableView].forEach {
            view.addSubview($0)
        }
        
        [titleLabel, settingButton].forEach {
            topView.addSubview($0)
        }
        
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(14.adjusted)
        }
        
        settingButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-15.adjusted)
            $0.width.height.equalTo(19.adjusted)
        }
        
        friendListTableView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10.adjusted)
        }
    }
    
    private func relayout() {
        friendListTableView.snp.remakeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10.adjusted)
        }
    }
    
    // MARK: - General Helpers
    
    private func register() {
        friendListTableView.register(
            FriendTableViewCell.self,
            forCellReuseIdentifier: FriendTableViewCell.identifier
        )
    }
}

// MARK: - UITableViewDelegate

extension FriendListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 73.adjusted
        } else {
            return 50.adjusted
        }
    }
}

// MARK: - UITableViewDataSource

extension FriendListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pinnedFriendList.count + friendList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let friendCell = tableView.dequeueReusableCell(
            withIdentifier: FriendTableViewCell.identifier, for: indexPath)
                as? FriendTableViewCell else { return UITableViewCell() }
        if indexPath.row == 0 {
            friendCell.dataBind(model: nil)
        }
        else {
            if pinnedFriendList.isEmpty {
                friendCell.dataBind(model: friendList[indexPath.row - 1 ])
            }
            else {
                if indexPath.row < pinnedFriendList.count + 1 {
                    friendCell.dataBind(model: pinnedFriendList[indexPath.row - 1])
                }
                else {
                    friendCell.dataBind(model: friendList[indexPath.row - 1 - pinnedFriendList.count])
                }
            }
        }

        return friendCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.row != 0 {
            let deleteAction = UIContextualAction(style: .destructive, title: "삭제", handler: { action, view, completionHandler in
                self.friendList.remove(at: indexPath.row - 1)
                tableView.reloadData()
                completionHandler(true)
            })
//            let pinAction = UIContextualAction(style: .normal, title: "고정", handler: { _, _, completionHandler in
//                if !self.friendList.isEmpty {
//                    self.pinnedFriendList.append(self.friendList[indexPath.row - 1])
//                    self.friendList.remove(at: indexPath.row - 1)
//                    tableView.reloadData()
//                    completionHandler(true)
//                }
//
//            })
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        return UISwipeActionsConfiguration(actions: [])
    }
}
