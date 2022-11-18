//
//  CGFloat+.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/10/15.
//

import Foundation
import UIKit

extension CGFloat {
    var adjusted: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 375
        let ratioH: CGFloat = UIScreen.main.bounds.height / 667
        return ratio <= ratioH ? self * ratio : self * ratioH
    }
}
