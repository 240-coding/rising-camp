//
//  Utils.swift
//  Week5
//
//  Created by 이서영 on 2022/09/09.
//

import Foundation
import UIKit

extension UIView {
    func setGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [#colorLiteral(red: 0.01176470588, green: 0.003921568627, blue: 0.02352941176, alpha: 1).cgColor, #colorLiteral(red: 0.04705882353, green: 0.01960784314, blue: 0.2196078431, alpha: 1).cgColor, #colorLiteral(red: 0.2, green: 0.1098039216, blue: 0.1882352941, alpha: 1).cgColor]
//        gradient.locations = [0.0, 0.5, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
}
