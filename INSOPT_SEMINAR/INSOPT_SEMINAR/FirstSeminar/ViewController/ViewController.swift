//
//  ViewController.swift
//  IN_SOPT_First_Seminar
//
//  Created by hansol on 2022/09/30.
//

import UIKit

class ViewController: UIViewController {

    private let testLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 400, width: 300, height: 100))
        label.text = "아요미들🍎"
        label.font = .boldSystemFont(ofSize: 40)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(testLabel)
    }
}

