//
//  GCDTestViewController.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/11/25.
//

import UIKit

// MARK: - GCDTestViewController

final class GCDTestViewController: UIViewController {

    // MARK: - Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<5 {
//            testSync(index: i)
            testAsync(index: i)
        }
    }
}

// MARK: - Extensions

extension GCDTestViewController {
    
    // MARK: - Helpers
    
    private func testSync(index: Int) {
        let concurrent = DispatchQueue(label: "concurrent", qos: .background, attributes: .concurrent)
        concurrent.sync { print("검수\(index)") }
        print("포장\(index)")
    }
    
    private func testAsync(index: Int) {
        let concurrent = DispatchQueue(label: "concurrent", qos: .background, attributes: .concurrent)
        concurrent.async { print("포장2") }
        print("포장1")
    }
}
