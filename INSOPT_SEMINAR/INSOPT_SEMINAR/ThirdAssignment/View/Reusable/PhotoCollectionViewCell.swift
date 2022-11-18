//
//  PhotoCollectionViewCell.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/10/22.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - PhotoCollectionViewCell

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "PhotoCollectionViewCell"
    
    // MARK: - UI Components
    
    private let imageContainerView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private lazy var imageView = UIImageView()
    private let countView = UIView().then {
        $0.layer.cornerRadius = 9.adjusted
        $0.backgroundColor = 0xF6DD2A.color
    }
    
    private let countLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 10, weight: .regular)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.layer.borderColor = UIColor.clear.cgColor
        countView.isHidden = true
    }
}

// MARK: - Extensions

extension PhotoCollectionViewCell {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        backgroundColor = .clear
        contentView.backgroundColor = 0xD9D9D9.color
        
        [imageContainerView, countView].forEach {
            contentView.addSubview($0)
        }
        
        imageContainerView.addSubview(imageView)
        countView.addSubview(countLabel)
        
        imageContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        countView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(4.adjusted)
            $0.width.height.equalTo(18.adjusted)
        }
        
        countLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func relayout(isFirst: Bool) {
        if isFirst {
            imageContainerView.snp.remakeConstraints {
                $0.center.equalToSuperview()
                $0.width.height.equalTo(35.adjusted)
            }
        } else {
            imageContainerView.snp.remakeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    
    // MARK: - General Helpers
    
    func dataBind(imageName: String?, count: Int) {
        if let imageName = imageName {
            imageView.image = UIImage(named: imageName)
            relayout(isFirst: false)
        } else {
            imageView.image = UIImage(named: "iconCamera")
            relayout(isFirst: true)
        }
        
        if count == 0 {
            contentView.layer.borderColor = UIColor.clear.cgColor
            contentView.layer.borderWidth = 3
            countView.isHidden = true
        } else {
            contentView.layer.borderColor = 0xF6DD2A.color.cgColor
            contentView.layer.borderWidth = 3
            countLabel.text = "\(count)"
            countView.isHidden = false
        }
    }
}
