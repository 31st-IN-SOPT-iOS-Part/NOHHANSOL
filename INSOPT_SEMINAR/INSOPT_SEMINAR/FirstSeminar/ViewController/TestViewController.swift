//
//  TestViewController.swift
//  IN_SOPT_First_Seminar
//
//  Created by hansol on 2022/09/30.
//

import UIKit

class TestViewController: UIViewController {
    
    private let firstView: UIView = {
        let view = UIView(frame: CGRect(x: 72, y: 79, width: 300, height: 500))
        view.backgroundColor = UIColor(cgColor: CGColor(red: 151/255, green: 189/255, blue: 255/255, alpha: 1))
        return view
    }()
    
    private let secondView: UIView = {
        let view = UIView(frame: CGRect(x: 98, y: 157, width: 100, height: 230))
        view.backgroundColor = UIColor(cgColor: CGColor(red: 144/255, green: 153/255, blue: 168/255, alpha: 1))
        return view
    }()
    
    private let changeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 170, y: 630, width: 80, height: 40))
        button.setTitle("옮겨져랏!", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(touchupChangeButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let components: [Any] = [firstView, secondView, changeButton]
        view.addSubview(firstView)
        view.addSubview(changeButton)
        firstView.addSubview(secondView)
    }
    
    @objc
    private func touchupChangeButton() {
        firstView.bounds.origin.x = 98
        firstView.bounds.origin.y = 157
    }
}
