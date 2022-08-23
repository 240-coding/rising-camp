//
//  Utils.swift
//  Week3
//
//  Created by 이서영 on 2022/08/23.
//

import Foundation

struct Utils {
    static func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
}
