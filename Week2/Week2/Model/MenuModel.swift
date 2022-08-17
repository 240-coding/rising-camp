//
//  MenuModel.swift
//  Week2
//
//  Created by 이서영 on 2022/08/18.
//

import Foundation
import UIKit

struct MenuModel {
    var imageName: String
    var name: String
    
    var image: UIImage {
        UIImage(named: imageName)!
    }
}
