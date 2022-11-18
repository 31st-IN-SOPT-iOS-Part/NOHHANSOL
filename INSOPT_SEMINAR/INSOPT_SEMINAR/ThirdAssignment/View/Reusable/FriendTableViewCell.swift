//
//  FriendTableViewCell.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/10/22.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - FriendTableViewCell

final class FriendTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "FriendTableViewCell"

    // MARK: - UI Components
    
    private let profileImageContainerView = UIView()
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel().then {
        $0.textColor = .black
    }
    
    private let messageLabel = UILabel().then {
        $0.textColor = 0xA6A6A6.color
        $0.font = .systemFont(ofSize: 11.adjusted, weight: .regular)
    }
    
    private let underLineView = UIView().then {
        $0.backgroundColor = 0xF7F7F7.color
        $0.isHidden = true
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        underLineView.isHidden = true
    }
}

// MARK: - Extensions

extension FriendTableViewCell {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        [profileImageContainerView, nameLabel, messageLabel, underLineView].forEach {
            contentView.addSubview($0)
        }
        
        profileImageContainerView.addSubview(profileImageView)
        
        profileImageContainerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16.adjusted)
            $0.width.equalTo(44.adjusted)
            $0.height.equalTo(41.adjusted)
        }
        
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.bottom.equalTo(profileImageContainerView.snp.centerY).offset(-2.adjusted)
            $0.leading.equalTo(profileImageContainerView.snp.trailing).offset(11.adjusted)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageContainerView.snp.centerY).offset(3.adjusted)
            $0.leading.equalTo(nameLabel)
        }
        
        underLineView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    private func relayout(isFirst: Bool) {
        if isFirst {
            profileImageContainerView.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().offset(16.adjusted)
                $0.width.equalTo(59.adjusted)
                $0.height.equalTo(58.adjusted)
            }
            
            underLineView.isHidden = false
        } else {
            profileImageContainerView.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().offset(16.adjusted)
                $0.width.equalTo(44.adjusted)
                $0.height.equalTo(41.adjusted)
            }
            
            underLineView.isHidden = true
        }
    }
    
    // MARK: - General Helpers
    
    func dataBind(model: KakaoFriendModel?) {
        if let model = model {
            profileImageView.image = UIImage(named: model.profileImage)
            nameLabel.text = model.name
            nameLabel.font = .systemFont(ofSize: 12.adjusted, weight: .semibold)
            messageLabel.text = model.message
            relayout(isFirst: false)
        } else {
            profileImageView.image = UIImage(named: "imageFriend")
            nameLabel.text = "김솝트"
            nameLabel.font = .systemFont(ofSize: 16.adjusted, weight: .semibold)
            messageLabel.text = "상태 메시지는 여기에"
            relayout(isFirst: true)
        }
    }
}
