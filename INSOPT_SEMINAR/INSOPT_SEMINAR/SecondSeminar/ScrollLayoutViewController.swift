//
//  ScrollLayoutViewController.swift
//  IN_SOPT_First_Seminar
//
//  Created by hansol on 2022/10/08.
//

import UIKit

import SnapKit

// MARK: - ScrollLayoutViewController

final class ScrollLayoutViewController: UIViewController {
    
    // MARK: - Lazy Components
    
    private lazy var containerView = UIScrollView()
    
    // MARK: - UI Components
    
    private let firstView = UIView()
    private let secondView = UIView()
    private let thirdView = UIView()
    private let firstButton = ProfileMenuButton(frame: .zero, image: "profileTalkImage", text: "나와의 채팅")
    private let secondButton = ProfileMenuButton(frame: .zero, image: "profileTalkImage", text: "프로필 편집")
    private let thirdButton = ProfileMenuButton(frame: .zero, image: "profileTalkImage", text: "카카오스토리")

    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        config()
        layout()
    }
}

// MARK: - Extensions

extension ScrollLayoutViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        view.addSubview(containerView)
        [firstView, secondView, thirdView].forEach {
            containerView.addSubview($0)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        firstView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo((self.view.safeAreaLayoutGuide))
            make.height.equalTo(337)
        }
        
        secondView.snp.makeConstraints { make in
            make.top.equalTo(self.firstView.snp.bottom).offset(45)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(337)
        }
        
        thirdView.snp.makeConstraints { make in
            make.top.equalTo(self.secondView.snp.bottom).offset(45)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(337)
            /// 뽀인트!!!!!!
            make.bottom.equalToSuperview().offset(-45)
        }
    }
    
    // MARK: - General Helpers
    
    private func config() {
        firstView.backgroundColor = .systemGray3
        secondView.backgroundColor = .systemRed
        thirdView.backgroundColor = .systemPink
    }
}
