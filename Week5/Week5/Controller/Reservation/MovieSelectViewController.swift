//
//  MovieSelectViewController.swift
//  Week5
//
//  Created by 이서영 on 2022/09/11.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

private let cellIdentifier = "MovieCell"
private let reuseIdentifier = "reusableView"

class MovieSelectViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieTitle = [String]()
    
    struct SearchData {
        let title: String
        let imageUrl: String
    }
    
    var searchData = [SearchData]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        collectionView.register(UINib(nibName: "MovieCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifier)
        fetchBoxOfficeData()
    }
    
    func setNavigationItem() {
        let item = UINavigationItem()
        
        item.title = "영화 선택"
        item.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: nil, action: nil)
        item.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeViewController))
        
        let navigationBar = UINavigationBar()
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .black
        
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        //Set navigation item we created to new navigation bar to display it
        navigationBar.items = [item]
    }
    
    @objc func closeViewController() {
        dismiss(animated: true)
    }
    
    // MARK: - Networking
    func fetchBoxOfficeData() {
        MovieInfo.shared.requestBoxofficeData { result in
            switch result {
            case .success(let data):
                for movie in data.boxOfficeResult.dailyBoxOfficeList {
                    self.movieTitle.append(movie.movieNm)
                }
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchSearchData(query: String) {
        MovieInfo.shared.requestAdditionalMovieData(query: query) { result in
            switch result {
            case .success(let data):
                for movie in data.items {
                    self.searchData.append(SearchData(title: movie.title, imageUrl: movie.image))
                }
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UICollectionView
extension MovieSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchData.isEmpty ? movieTitle.count : searchData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if searchData.isEmpty {
            MovieInfo.shared.requestAdditionalMovieData(query: movieTitle[indexPath.row]) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        if let url = URL(string: data.items[0].image) {
                            cell.posterImageView.load(url: url)
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
            cell.titleLabel.text = movieTitle[indexPath.row]
        } else {
            cell.titleLabel.text = searchData[indexPath.row].title.htmlConvertedString
            if let url = URL(string: searchData[indexPath.row].imageUrl) {
                cell.posterImageView.load(url: url)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 16
        let height: CGFloat = 240
        return CGSize(width: width, height: height)
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { [self] (accessTokenInfo, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                    }
                    else {
                        //기타 에러
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    let title = searchData.isEmpty ? movieTitle[indexPath.row] : searchData[indexPath.row].title.htmlConvertedString
                    let sheet = UIAlertController(title: title, message: "예매하시겠습니까?", preferredStyle: .alert)
                    
                    sheet.addAction(UIAlertAction(title: "아니오", style: .cancel))
                    sheet.addAction(UIAlertAction(title: "예", style: .default, handler: { _ in
                        let userDefaults = UserDefaults.standard
                        guard let userId = accessTokenInfo?.id else {
                            print("ID 불러오기 실패")
                            return
                        }
                        var userMovieList = userDefaults.object(forKey: String(userId)) as? [String] ?? []
                        userMovieList.append(title)
                        userDefaults.set(userMovieList, forKey: String(userId))
                        print(userMovieList)
                    }))
                    DispatchQueue.main.async {
                        self.present(sheet, animated: true)
                    }
                    
                }
            }
        }
        else {
            //로그인 필요
            let sheet = UIAlertController(title: "알림", message: "로그인하셔야 합니다.", preferredStyle: .alert)

            sheet.addAction(UIAlertAction(title: "취소", style: .cancel))
            sheet.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                guard let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as? LoginViewController else {
                    return
                }
                loginViewController.modalPresentationStyle = .fullScreen
                self.present(loginViewController, animated: true)
            }))

            self.present(sheet, animated: true)
        }
    }
    
    // Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifier, for: indexPath) as? MovieCollectionReusableView else {
                return UICollectionReusableView()
            }
            headerView.searchBar.delegate = self
            return headerView
        default:
            assert(false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        let height = 100.0
        
        return CGSize(width: width, height: height)
    }
    
}

extension MovieSelectViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchData = []
        if let query = searchBar.text {
            if query.isEmpty {
                collectionView.reloadData()
            } else {
                fetchSearchData(query: query)
            }
        }
    }
}
