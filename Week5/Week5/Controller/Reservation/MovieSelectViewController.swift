//
//  MovieSelectViewController.swift
//  Week5
//
//  Created by 이서영 on 2022/09/11.
//

import UIKit

private let cellIdentifier = "MovieCell"
private let reuseIdentifier = "reusableView"

class MovieSelectViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieTitle = [String]()

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
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UICollectionView
extension MovieSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
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
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 16
        let height: CGFloat = 240
        return CGSize(width: width, height: height)
    }
    
    // Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifier, for: indexPath) as? MovieCollectionReusableView else {
                return UICollectionReusableView()
            }
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
