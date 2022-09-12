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

extension UIViewController {
    func setNavigationBarBackground() {
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            navigationController!.navigationBar.standardAppearance = navigationBarAppearance
            navigationController!.navigationBar.standardAppearance.backgroundColor = UIColor(named: "navigation")
            navigationController!.navigationBar.compactAppearance = navigationBarAppearance
            navigationController!.navigationBar.scrollEdgeAppearance = navigationBarAppearance
            navigationController!.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor.clear
            navigationController!.navigationBar.tintColor = .white
            navigationController!.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.backward")
            navigationController!.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward")
        }
    }
    
    func setNavigationBarItems() {
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "ticket"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func numberFormatter(number: String) -> String {
        guard let number = Int(number) else { return "" }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension String{
    var htmlConvertedString : String{
        let string = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        return string
    }}
