//
//  ProfileMenuButton.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/11/10.
//

import UIKit

import SnapKit
import Then

// MARK: - ProfileMenuButton

final class ProfileMenuButton: UIView {
    
    // MARK: - UI Component
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    
    // MARK: - Init
    
    init(frame: CGRect, image: String, text: String) {
        super.init(frame: frame)
        imageView.image = UIImage(named: image)
        titleLabel.text = text
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Extensions

extension ProfileMenuButton {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        
    }
    
    // MARK: - General Helpers
    
    func config(image: String, text: String) {
        imageView.image = UIImage(named: image)
        titleLabel.text = text
    }
}
