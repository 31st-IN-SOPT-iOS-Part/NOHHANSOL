//
//  ThirdViewController.swift
//  IN_SOPT_First_Seminar
//
//  Created by hansol on 2022/10/05.
//

import UIKit

class ThirdViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 300, width: 200, height: 40))
        label.text = "ThirdVC"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self.navigationController?.children)
    }
}
