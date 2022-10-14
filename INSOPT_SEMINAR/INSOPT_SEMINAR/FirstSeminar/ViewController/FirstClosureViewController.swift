//
//  FirstClosureViewController.swift
//  IN_SOPT_First_Seminar
//
//  Created by hansol on 2022/10/05.
//

import UIKit

class FirstClosureViewController: UIViewController {
 
    private let questionLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 80, y: 200, width: 250, height: 30))
        label.text = "민초 vs 반민초 당신의 선택은?"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let answerTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 80, y: 280, width: 250, height: 40))
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
        textField.font = .systemFont(ofSize: 18, weight: .medium)
        return textField
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 80, y: 350, width: 250, height: 42))
        button.setTitle("다음으로", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(touchupNextButton), for: .touchUpInside)
        return button
    }()
    
    private let answerLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 80, y: 420, width: 300, height: 30))
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let components: [Any] = [questionLabel, answerTextField, nextButton, answerLabel]
        components.forEach {
            view.addSubview($0 as! UIView)
        }
    }
    
    private func presentToSecondVC() {
        let fourthVC = SecondClosureViewController()
        fourthVC.modalPresentationStyle = .formSheet
        
//        fourthVC.result = answerTextField.text
//        fourthVC.dataBind()
        
        if let answer = answerTextField.text {
            fourthVC.dataBind(result: answer)
        }
        
        fourthVC.dataSendClosure = { result in
            self.dataSend(answer: result)
        }
        
        self.present(fourthVC, animated: true, completion: nil)
    }
    
    private func pushToSecondVC() {
        let fourthVC = SecondClosureViewController()
        
//        fourthVC.result = answerTextField.text
//        fourthVC.dataBind()
        
        if let answer = answerTextField.text {
            fourthVC.dataBind(result: answer)
        }
        
        fourthVC.dataSendClosure = { result in
            self.dataSend(answer: result)
        }
        
        self.navigationController?.pushViewController(fourthVC, animated: true)
    }
    
    func dataSend(answer: String) {
        answerLabel.text = answer
    }
    
    @objc
    private func touchupNextButton() {
//      presentToSecondVC()
        pushToSecondVC()
    }
}
