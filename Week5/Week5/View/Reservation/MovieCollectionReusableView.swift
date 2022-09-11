//
//  MovieCollectionReusableView.swift
//  Week5
//
//  Created by 이서영 on 2022/09/11.
//

import UIKit

class MovieCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var searchBar: UISearchBar!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureSearchBar()
    }
    
    func configureSearchBar() {
        let searchTextField: UITextField = searchBar.value(forKey: "searchField") as? UITextField ?? UITextField()
        searchBar.searchTextField.backgroundColor = .white
        searchTextField.backgroundColor = .white
        searchTextField.layer.borderColor = UIColor.lightGray.cgColor
        searchTextField.layer.borderWidth = 1
        searchTextField.font = .systemFont(ofSize: 14)
        searchTextField.textAlignment = NSTextAlignment.left
        let image: UIImage = UIImage(systemName: "magnifyingglass")!
        let imageView: UIImageView = UIImageView.init(image: image)
        imageView.tintColor = .black
        searchTextField.leftView = nil
        searchTextField.rightView = imageView
        searchTextField.rightViewMode = UITextField.ViewMode.always


    }
    
}
