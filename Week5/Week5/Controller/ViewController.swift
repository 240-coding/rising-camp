//
//  ViewController.swift
//  Week5
//
//  Created by 이서영 on 2022/09/04.
//

import UIKit

private let eventCellIdentifier = "HomeEventCell"
private let categoryCellIdentifier = "HomeCategoryCell"

private let category = ["박스오피스", "상영예정", "돌비시네마", "라스트특가", "단독", "클소", "필스"]

class ViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var selectedCategoryCell = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gradientView.setGradient()
        configureNavigationBar()
        configureEventCollectionView()
        configureRoundView()
    }
    
    func configureNavigationBar() {
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "ticket"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = leftBarButton
        
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func configureEventCollectionView() {
        self.eventCollectionView.backgroundView?.backgroundColor = UIColor.clear
        self.eventCollectionView.backgroundColor = UIColor.clear
    }
    
    func configureRoundView() {
        roundView.layer.cornerRadius = 20
        roundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

// MARK: - UICollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == eventCollectionView {
            return 10
        } else if collectionView == categoryCollectionView {
            return category.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == eventCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCellIdentifier, for: indexPath) as? HomeEventCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        } else if collectionView == categoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellIdentifier, for: indexPath) as? HomeCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.label.text = "#\(category[indexPath.row])"
            
            if indexPath.row == selectedCategoryCell {
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
                cell.isSelected = true
            }
            return cell
        }
        
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = 0, height: CGFloat = 0
        if collectionView == eventCollectionView {
            width = 100
            height = 125
        } else if collectionView == categoryCollectionView {
            let label: UILabel = {
                let label = UILabel()
                label.text = category[indexPath.item]
                label.font = .systemFont(ofSize: 17)
                label.sizeToFit()
                return label
            }()
            width = label.frame.width + 30
            height = 50
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            print(indexPath.row)
            guard let cell = collectionView.cellForItem(at: indexPath) as? HomeCategoryCollectionViewCell else { return }
            cell.configureSelectedStatus()
            selectedCategoryCell = indexPath.row
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if collectionView == categoryCollectionView {
//            guard let cell = collectionView.cellForItem(at: indexPath) as? HomeCategoryCollectionViewCell else { return }
//            cell.configureUnselectedStatus()
//        }
//    }
//
}
//
//override var isSelected: Bool {
//    willSet {
//        super.isSelected = newValue
//        if newValue {
//            label.font = .systemFont(ofSize: 17)
//            label.textColor = UIColor(named: "navy")
//            bottomView.isHidden = false
//        } else {
//            label.font = .systemFont(ofSize: 17, weight: .light)
//            label.textColor = .gray
//            bottomView.isHidden = true
//        }
//    }
//}
