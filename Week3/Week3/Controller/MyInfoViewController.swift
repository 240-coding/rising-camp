//
//  MyInfoViewController.swift
//  Week3
//
//  Created by 이서영 on 2022/08/23.
//

import UIKit

class MyInfoViewController: UIViewController {
    
    private let cellIdentifier = "MyInfoCell"
    let sectionTitle = ["나의 활동", "우리 동네", "사장님 메뉴", "기타"]
    let sectionMenuName = [["내 동네 설정", "동네 인증하기", "키워드 알림", "모아보기", "당근가계부", "관심 카테고리 설정"], ["동네생활 글/댓글", "동네홍보 글", "동네 가게 후기", "저장한 장소", "내 단골 가게", "받은 쿠폰함"], ["비즈프로필 만들기", "광고"], ["친구초대", "공지사항", "자주 묻는 질문", "앱 설정"]]
    var sectionMenuImage: [[String]] = [[], [], [], []]
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerNib = UINib(nibName: "MyInfoTableViewHeader", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "myInfoHeader")
        let titleHeaderNib = UINib(nibName: "MyInfoTitleTableViewHeader", bundle: nil)
        tableView.register(titleHeaderNib, forHeaderFooterViewReuseIdentifier: "myInfoTitleHeader")
        
        tableView.sectionFooterHeight = 10
        
        var index = 1
        for i in 0..<sectionMenuImage.count {
            for _ in 0..<sectionMenuName[i].count {
                sectionMenuImage[i].append("menu\(index)")
                index += 1
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MyInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : sectionMenuName[section-1].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MyInfoTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = sectionMenuName[indexPath.section-1][indexPath.row]
        cell.iconImageView.image = UIImage(named: sectionMenuImage[indexPath.section-1][indexPath.row])
        return cell
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "myInfoHeader") as! MyInfoTableViewHeader
            
            header.profileImageView.layer.masksToBounds = true
            header.profileImageView.layer.cornerRadius = header.profileImageView.frame.height / 2
            header.profileImageView.layer.borderColor = UIColor.systemGray5.cgColor
            header.profileImageView.layer.borderWidth = 1
            header.menuIconImageView1.layer.masksToBounds = true
            header.menuIconImageView1.layer.cornerRadius = header.menuIconImageView1.frame.height / 2
            header.menuIconImageView2.layer.masksToBounds = true
            header.menuIconImageView2.layer.cornerRadius = header.menuIconImageView2.frame.height / 2
            header.menuIconImageView3.layer.masksToBounds = true
            header.menuIconImageView3.layer.cornerRadius = header.menuIconImageView3.frame.height / 2

            header.payView.layer.borderWidth = 1.5
            header.payView.layer.borderColor = UIColor(named: "Orange")?.cgColor
            header.payView.layer.cornerRadius = 5
            
            return header
        } else {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "myInfoTitleHeader") as! MyInfoTitleTableViewHeader
            
            header.titleLabel.text = sectionTitle[section-1]
                        
            return header
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 300 : 55
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
