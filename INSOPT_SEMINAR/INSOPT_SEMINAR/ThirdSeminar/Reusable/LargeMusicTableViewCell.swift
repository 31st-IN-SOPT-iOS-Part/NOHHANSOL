//
//  LargeMusicTableViewCell.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/10/15.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - LargeMusicTableViewCell

final class LargeMusicTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "LargeMusicTableViewCell"

    // MARK: - UI Components
    
    private let albumContainerView = UIView()
    private let albumImageView = UIImageView()
    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 17, weight: .medium)
    }
    
    private let singerLabel = UILabel().then {
        $0.textColor = 0x1E1E1E.color
        $0.font = .systemFont(ofSize: 15, weight: .medium)
    }
    
    private lazy var clickableButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "iconClickable"), for: .normal)
        return button
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension LargeMusicTableViewCell {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        [albumContainerView, titleLabel, singerLabel, clickableButton].forEach {
            contentView.addSubview($0)
        }
        
        albumContainerView.addSubview(albumImageView)
        albumContainerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(58)
        }
        
        albumImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(albumContainerView).offset(10)
            $0.leading.equalTo(albumContainerView.snp.trailing).offset(15)
        }
        
        singerLabel.snp.makeConstraints {
            $0.bottom.equalTo(albumImageView).offset(-10)
            $0.leading.equalTo(titleLabel)
        }
        
        clickableButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-25)
            $0.width.height.equalTo(24)
        }
    }
    
    // MARK: - General Helpers
    
    func dataBind(model: MusicModel) {
        albumImageView.image = UIImage(named: model.albumImage)
        titleLabel.text = model.title
        singerLabel.text = model.singer
    }
}
