//
//  LifeViewController.swift
//  Week3
//
//  Created by 이서영 on 2022/08/23.
//

import UIKit

class LifeViewController: UIViewController {
    
    let tagCellIdentifier = "TagCell"
    let contentCellIdentifier = "ContentCell"
    
    let tagList = ["같이해요", "동네질문", "동네맛집", "동네소식", "취미생활", "분실/실종센터", "동네사건사고", "해주세요", "일상", "동네사진전", "실시간 동네날씨"]
    let contentList: [LifeModel] = [
        LifeModel(category: "동네질문", description: "북아현동 근처에 다이어트 한약 잘 지어주는 곳 아시나요? 한약 다이어트 생각 중인데 가까웠음 좋겠어요 ㅠㅠ", username: "지쵸미", location: "북아현동", time: "6시간 전"),
        LifeModel(category: "동네질문", description: "신촌 김삼보 몇시까지 문 여나요???", username: "파랑", location: "대현동", time: "12시간 전"),
        LifeModel(category: "분실/실종센터", description: "서울디자인고앞 따릉이 정거장에 중앙일보 직원분 회사출입목걸이 있네요", username: "이난", location: "염리동", time: "12시간 전", photo: UIImage(named: "img")),
        LifeModel(category: "해주세요", description: "헤어 프로필 사진 찍을려고 합니다 동네 사진관추첨좀 해 주세요 아무리 검색해도 괜찮은데가 ㅠㅠㅠㅠ 모르겠어요", username: "뿡어", location: "창천동", time: "12시간 전"),
    ]
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var contentCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

}

extension LifeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == self.tagCollectionView ? tagList.count : contentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.tagCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagCellIdentifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
            
            cell.tagLabel.text = tagList[indexPath.row]
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell() }
            let data = contentList[indexPath.row]
            
            var text = ""
            if data.category == "동네질문" {
                text = "Q. "
            } else if data.category == "분실/실종센터" {
                text = "찾아요 "
            }
            
            
            let attributedText = NSMutableAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor(named: "Orange") ?? UIColor.blue])
            attributedText.append(NSAttributedString(string: data.description, attributes: [.font: UIFont.systemFont(ofSize: 17)]))
            
            cell.categoryLabel.text = data.category
            cell.descriptionLabel.attributedText = attributedText
            cell.usernameLabel.text = data.username
            cell.locationLabel.text = data.location
            cell.timeLabel.text = data.time
            cell.photoImageView.image = data.photo ?? UIImage()
            
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.tagCollectionView {
            let label = UILabel()

            label.font = .systemFont(ofSize: 14)
            label.text = tagList[indexPath.row]
            label.sizeToFit()
            
            let size = label.frame.size
            
            return CGSize(width: size.width + 24, height: size.height + 16)
        } else {
            let imageView = contentList[indexPath.row].photo
            
            return CGSize(width: collectionView.frame.width, height: imageView == nil ? 415-200 : 415)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return collectionView == self.tagCollectionView ? UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16) : UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
    }
    
    
}
