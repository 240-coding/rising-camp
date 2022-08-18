//
//  MenuListModel.swift
//  Week2
//
//  Created by 이서영 on 2022/08/18.
//

import Foundation
import UIKit

struct MenuListModel {
    var title: String
    var menus: [MenuInfoModel]
}

struct MenuInfoModel {
    var menuName: String
    var price: Int
    var menuImageName: String
    var menuImage: UIImage {
        UIImage(named: menuImageName) ?? UIImage()
    }
}
