//
//  ChatViewController.swift
//  Week3
//
//  Created by 이서영 on 2022/08/23.
//

import UIKit

class ChatViewController: UIViewController {
    
    private let cellIdentifier = "ChatCell"
    
    let chatModel: [ChatModel] = [
        ChatModel(profileImage: UIImage(named: "profile1"), badgeImage: UIImage(named: "badge1"), username: "영웅호걸", location: "합정동", time: "3달 전", message: "구매가능하세요!"),
        ChatModel(profileImage: UIImage(named: "profile2"), username: "겨울호호", location: "운양동", time: "3달 전", message: "CPU랑 용량을 업그레이드 했다는데.. 그런데 잘 안 돌아가요", messageImage: UIImage(named: "message")),
        ChatModel(profileImage: UIImage(named: "profile3"), username: "모래요정", location: "성산동", time: "3달 전", message: "도착했어요", messageImage: UIImage(named: "message")),
        ChatModel(username: "중고매물다내꺼", location: "부평동", time: "3달 전", message: "아직 거래가능한 상품인가요?"),
        ChatModel(username: "홍기", location: "성산제1동", time: "3달 전", message: "배터리 상태 보여주실까요?"),
        ChatModel(username: "Ekdrms", location: "성산제1동", time: "3달 전", message: "안녕하세요! 물건 보고 관심 있어서 연락드립니다."),
        ChatModel(profileImage: UIImage(named: "profile3"), username: "모래요정", location: "성산동", time: "3달 전", message: "혹시 구매 취소하시는지 궁금합니다~"),
        ChatModel(username: "몰로롤라", location: "신수동", time: "4달 전", message: "로직프로는 없습니다.!"),
        ChatModel(badgeImage: UIImage(named: "badge2"), username: "Piolife", location: "산척면", time: "6달 전", message: "네"),

    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let data = chatModel[indexPath.row]
        if let profileImage = data.profileImage {
            cell.profileImageView.image = profileImage
        }
        if let badgeImage = data.badgeImage {
            cell.badgeImageView.image = badgeImage
        } else {
            cell.badgeImageView.isHidden = true
        }
        cell.nameLabel.text = data.username
        cell.locationLabel.text = data.location
        cell.timeLabel.text = data.time
        cell.messageLabel.text = data.message
        if let messagePhotoImage = data.messageImage {
            cell.messagePhotoImageView.image = messagePhotoImage
        } else {
            cell.messagePhotoImageView.isHidden = true
            cell.messageLabelTrailing.isActive = false
            cell.messageLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -32).isActive = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    
}
