//
//  LoadImagesViewController.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/11/25.
//

import Foundation
import UIKit

import SnapKit
import Then

// MARK: - LoadImagesViewController

final class AnswerLoadImagesViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let imageView = UIImageView()
    
    // MARK: - Variables
    
    var timeTrigger: Bool = true
    var realTime = Timer()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        startAction()
    }
}

// MARK: - Extensions

extension AnswerLoadImagesViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(400.adjusted)
            $0.height.equalTo(300.adjusted)
        }
    }
    
    // MARK: - General Helpers
    
    private func startAction() {
        if timeTrigger {
            checkTimeTrigger()
        }
    }
    
    private func checkTimeTrigger() {
        realTime = Timer.scheduledTimer(timeInterval: 0.01, target: self,
                                        selector: #selector(start), userInfo: nil, repeats: true)
        timeTrigger = false
    }
    
    private func resizedImage(at url: URL, for size: CGSize) -> UIImage? {
        guard let image = UIImage(contentsOfFile: url.path) else {
            return nil
        }

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    private func resizedImage(at data: Data, for size: CGSize) -> UIImage? {
        guard let image = UIImage(data: data) else {
            return nil
        }
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    private func urlToData(url: URL) -> Data {
        return try! Data(contentsOf: url)
    }
    
    private func dataToImage(data: Data) -> UIImage {
        guard let image = self.resizedImage(at: data, for: CGSize(width: 400.adjusted, height: 300.adjusted)) else { return UIImage() }
        return image
    }
    
    private func setImage(image: UIImage) {
        imageView.image = image
    }

    private func fetchImages() {
        let url = URL(string: "https://picsum.photos/3840/2160/?random")!
        DispatchQueue.global().async { [weak self] in
            guard let data = self?.urlToData(url: url) else { return }
            guard let image = self?.dataToImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.setImage(image: image)
            }
        }
    }
    
    // MARK: - Objc Helpers
    
    @objc
    private func start() {
        self.fetchImages()
    }
}
