//
//  ViewController.swift
//  Week3
//
//  Created by 이서영 on 2022/08/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let cellIdentifier = "HomeCell"
    
    let homeData: [HomeModel] = [
        HomeModel(title: "갤럭시탭s7+ 팝니다", location: "마포구 아현동", promotion: 2, price: 600000, comment: 0, heart: 2),
        HomeModel(title: "아이폰 8 실버", location: "은평구 역촌동", promotion: 3, price: 110000, comment: 7, heart: 16),
        HomeModel(title: "아이폰11프로64 하자X 빠르게 정리", location: "마포구 대흥동", promotion: 4, price: 480000, comment: 5, heart: 3),
        HomeModel(title: "애플 매직키보드2 영문자판", location: "남가좌동", promotion: 7, price: 90000, comment: 1, heart: 17),
        HomeModel(title: "i7 고사양 사무용 컴퓨터 본체", location: "마포구 대현동", promotion: 3, price: 450000, comment: 2, heart: 9),
        HomeModel(title: "삼성 유선청소기", location: "마포구 아현동", promotion: 2, price: 30000, comment: 0, heart: 7)
    ]
    
    @IBOutlet var addButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        configureTabBar()
        configureAddButton()
    }
    
    func configureTabBar() {
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor(named: "Black")
        self.tabBarController?.tabBar.backgroundColor = .white
        self.tabBarController?.tabBar.layer.borderWidth = 0.5
        self.tabBarController?.tabBar.layer.borderColor = UIColor.lightGray.cgColor
        self.tabBarController?.tabBar.clipsToBounds = true
    }

    func configureAddButton() {
        addButton.layer.cornerRadius = addButton.frame.height / 2
        addButton.layer.shadowColor = UIColor.lightGray.cgColor
        addButton.layer.shadowOpacity = 0.5
        addButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        addButton.layer.shadowRadius = 5
    }
    
    @IBAction func pressAddButton(_ sender: Any) {
        print("Pressed Button")
    }
    

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        cell.thumbnailImageView.image = UIImage(named: "thumbnail")
        cell.titleLabel.text = homeData[indexPath.row].title
        cell.locationLabel.text = homeData[indexPath.row].location
        cell.promotionLabel.text = "끌올 \(homeData[indexPath.row].promotion)분 전"
        cell.priceLabel.text = Utils.numberFormatter(number: homeData[indexPath.row].price) + "원"
        if homeData[indexPath.row].comment == 0 {
            cell.commentsImageView.isHidden = true
            cell.commentsLabel.isHidden = true
        } else {
            cell.commentsLabel.text = String(homeData[indexPath.row].comment)
        }
        if homeData[indexPath.row].heart == 0 {
            cell.heartImageView.isHidden = true
            cell.heartLabel.isHidden = true
        } else {
            cell.heartLabel.text = String(homeData[indexPath.row].heart)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
