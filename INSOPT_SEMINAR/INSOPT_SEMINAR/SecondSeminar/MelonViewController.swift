//
//  MelonViewController.swift
//  IN_SOPT_First_Seminar
//
//  Created by hansol on 2022/10/12.
//

import UIKit

import SwiftyColor
import Then

// MARK: - MelonViewController

final class MelonViewController: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var containerView = UIScrollView().then {
        $0.bounces = false
        $0.showsVerticalScrollIndicator = false
    }
    
    private let topView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let standardLabel = UILabel().then {
        $0.text = "오늘 18:00 기준"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15, weight: .medium)
    }
    
    private let rankLabel = UILabel().then {
        $0.text = "멜론TOP100"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 21)
    }
    
    private let graphContainerView = UIView()
    private let graphImageView = UIImageView().then {
        $0.image = UIImage(named: "imgGraph")
    }
    
    private lazy var entireButton = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
    }
    
    private lazy var nowButton = UIButton().then {
        $0.setTitle("NOW", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        $0.backgroundColor = 0x56BC4E.color
        $0.layer.cornerRadius = 14
    }
    
    private let musicView = UIView().then {
        $0.backgroundColor = 0xD9D9D9.color
        $0.layer.cornerRadius = 10
    }
    
    private let trackLabel = UILabel().then {
        $0.text = "목요일은 트랙제로, 전문가 추천 음악"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    private let djContainerView = UIView()
    private let djImageView = UIImageView().then {
        $0.image = UIImage(named: "imageDJ")
    }
    
    private let playView = UIView().then {
        $0.backgroundColor = 0x56BC42.color
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 10
    }
    
    private lazy var playListButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "icon_menu"), for: .normal)
    }
    
    private let songTitleLabel = UILabel().then {
        $0.text = "Blueming"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
    }
    
    private let singerLabel = UILabel().then {
        $0.text = "아이유"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 11, weight: .semibold)
    }
    
    private lazy var rewindButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "iconRewind"), for: .normal)
    }
    
    private lazy var playButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "iconPlay"), for: .normal)
    }
    
    private lazy var fastForwardButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "iconFastForward"), for: .normal)
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
}

// MARK: - Extensions

extension MelonViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        view.backgroundColor = .white
        [containerView, playView].forEach {
            view.addSubview($0)
        }
        
        [topView, nowButton, musicView, trackLabel, djContainerView].forEach {
            containerView.addSubview($0)
        }
        
        djContainerView.addSubview(djImageView)
        [standardLabel, rankLabel, graphContainerView, entireButton].forEach {
            topView.addSubview($0)
        }
        
        graphContainerView.addSubview(graphImageView)
        
        [
            playListButton,
            songTitleLabel,
            singerLabel,
            rewindButton,
            playButton,
            fastForwardButton
        ].forEach {
            playView.addSubview($0)
        }
        
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
        let window = UIApplication.shared.keyWindow
        guard let topInset = window?.safeAreaInsets.bottom else { return }
        playView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(54 + topInset)
        }
        
        topView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(98)
        }
        
        standardLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.equalToSuperview().offset(21)
        }
        
        rankLabel.snp.makeConstraints {
            $0.top.equalTo(self.standardLabel.snp.bottom).offset(5)
            $0.leading.equalTo(self.standardLabel)
        }
        
        graphContainerView.snp.makeConstraints {
            $0.bottom.equalTo(self.rankLabel)
            $0.leading.equalTo(self.rankLabel.snp.trailing).offset(6)
            $0.width.equalTo(11)
            $0.height.equalTo(19)
        }
        
        graphImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        entireButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.trailing.equalToSuperview().offset(-27)
            $0.width.equalTo(52)
            $0.height.equalTo(18)
        }
        
        nowButton.snp.makeConstraints {
            $0.top.equalTo(self.topView.snp.bottom).offset(6)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.width.equalTo(72)
            $0.height.equalTo(32)
        }
        
        musicView.snp.makeConstraints {
            $0.top.equalTo(self.nowButton.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(253)
        }
        
        trackLabel.snp.makeConstraints {
            $0.top.equalTo(self.musicView.snp.bottom).offset(63)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(20)
        }
        
        djContainerView.snp.makeConstraints {
            $0.top.equalTo(self.trackLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(250.13)
            $0.bottom.equalToSuperview()
        }
        
        djImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        playListButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(15)
            $0.width.equalTo(29)
            $0.height.equalTo(28)
        }
        
        songTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.playListButton).offset(-3)
            $0.leading.equalTo(self.playListButton.snp.trailing).offset(8)
        }
        
        singerLabel.snp.makeConstraints {
            $0.top.equalTo(self.songTitleLabel.snp.bottom).offset(1)
            $0.leading.equalTo(self.playListButton.snp.trailing).offset(9)
        }
        
        fastForwardButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-11)
            $0.width.height.equalTo(24)
        }
        
        playButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalTo(self.fastForwardButton.snp.leading).offset(-8)
            $0.width.height.equalTo(31)
        }
        
        rewindButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.trailing.equalTo(self.playButton.snp.leading).offset(-6)
            $0.width.height.equalTo(24)
        }
    }
}
