//
//  CGFloat+.swift
//  INSOPT_SEMINAR
//
//  Created by hansol on 2022/10/22.
//

import Foundation
import UIKit

// MARK: - CGFloat Extensions

extension CGFloat {
    var adjusted: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 375
        let ratioH: CGFloat = UIScreen.main.bounds.height / 667
        return ratio <= ratioH ? self * ratio : self * ratioH
    }
    
    var adjustedH: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.height / 667
        return self * ratio
    }
    
    var adjustedW: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 375
        return self * ratio
    }

}
