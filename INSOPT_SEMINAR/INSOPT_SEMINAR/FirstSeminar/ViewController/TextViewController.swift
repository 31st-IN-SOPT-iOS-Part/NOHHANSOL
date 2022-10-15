//
//  TextViewController.swift
//  IN_SOPT_First_Seminar
//
//  Created by hansol on 2022/09/30.
//

import UIKit

class TextViewController: UIViewController {
    
    private let testTextField: UITextField = {
        let frame = CGRect(x: 120, y: 300, width: 200, height: 40)
        let textField = UITextField(frame: frame)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(testTextField)
        // Do any additional setup after loading the view.
    }
}
