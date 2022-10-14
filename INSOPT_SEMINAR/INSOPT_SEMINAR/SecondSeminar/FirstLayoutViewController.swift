//
//  FirstLayoutViewController.swift
//  IN_SOPT_First_Seminar
//
//  Created by hansol on 2022/10/07.
//

import UIKit

import SnapKit

// MARK: - FirstLayoutViewController

final class FirstLayoutViewController: UIViewController {
    
    // MARK: - UIComponents
    
    private let firstView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    private let secondView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        return view
    }()
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }
}

// MARK : - Extensions

extension FirstLayoutViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        [firstView, secondView].forEach {
            view.addSubview($0)
        }
        
        firstView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(275)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(62)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-62)
            make.height.equalTo(155)
        }
        
        secondView.snp.makeConstraints {
            $0.top.equalTo(self.firstView.snp.bottom).offset(96)
            $0.leading.equalTo(self.firstView)
            $0.width.equalTo(109)
            $0.height.equalTo(106)
        }
    }
    
    /// 아래 두 함수는 모든 케이스를 담은 함수입니다. 실행금지!
    
    private func layoutFirstView() {
        view.addSubview(firstView)
        
        firstView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(275)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(62)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-62)
            make.height.equalTo(155)
        }
        
        firstView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(275)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(62)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-62)
            make.height.equalTo(155)
        }
        
        firstView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(275)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(62)
            make.height.equalTo(155)
        }
        
        firstView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(275)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(62)
            make.height.equalTo(155)
        }
    }

    private func layoutSecondView() {
        view.addSubview(secondView)
        
        secondView.snp.makeConstraints { make in
            make.top.equalTo(self.firstView.snp.bottom).offset(96)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(62)
            make.width.equalTo(109)
            make.height.equalTo(106)
        }

        secondView.snp.makeConstraints {
            $0.top.equalTo(self.firstView.snp.bottom).offset(96)
            $0.leading.equalTo(self.firstView.snp.leading)
            $0.width.equalTo(109)
            $0.height.equalTo(106)
        }
        
        secondView.snp.makeConstraints {
            $0.top.equalTo(self.firstView.snp.bottom).offset(96)
            $0.leading.equalTo(self.firstView)
            $0.width.equalTo(109)
            $0.height.equalTo(106)
        }
    }
}
