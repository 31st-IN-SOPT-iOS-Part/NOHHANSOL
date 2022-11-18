//
//  SingerCategoryCollectionViewCell.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/11/16.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - SingerCategoryCollectionViewCell

final class SingerCategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "SingerCategoryCollectionViewCell"
    
    // MARK: - UI Components
    
    private let singerLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 13.adjusted, weight: .medium)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 6.adjusted
    }
}

// MARK: - Extensions

extension SingerCategoryCollectionViewCell {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(singerLabel)
        singerLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - General Helpers
    
    func dataBind(singer: String, isSelected: Bool) {
        singerLabel.text = singer
        if isSelected {
            singerLabel.textColor = 0x49CC66.color
            contentView.layer.borderColor = 0x49CC66.color.cgColor
            contentView.layer.borderWidth = 1
        } else {
            singerLabel.textColor = .black
            contentView.layer.borderColor = 0xA6A6A6.color.cgColor
            contentView.layer.borderWidth = 1
        }
    }
}
