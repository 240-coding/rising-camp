//
//  BottomInfoView.swift
//  Week5
//
//  Created by 이서영 on 2022/09/11.
//

import UIKit

class BottomInfoView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
    }
    
    private func loadView() {
        let view = Bundle.main.loadNibNamed("BottomInfoView", owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)
    }

}
