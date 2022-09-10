//
//  GradientView.swift
//  Week5
//
//  Created by 이서영 on 2022/09/11.
//

import UIKit

class GradientView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
        
    }
    
    private func loadView() {
        let view = Bundle.main.loadNibNamed("GradientView", owner: self, options: nil)?.first as! UIView
        view.setGradient()
        addSubview(view)
    }
}
