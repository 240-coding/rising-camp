//
//  ViewController.swift
//  Week5
//
//  Created by 이서영 on 2022/09/04.
//

import UIKit
import Alamofire

private let eventCellIdentifier = "HomeEventCell"
private let categoryCellIdentifier = "HomeCategoryCell"
private let movieCellIdentifier = "HomeMovieCell"

private let category = ["박스오피스", "상영예정", "돌비시네마", "라스트특가", "단독", "클소", "필스"]

struct MovieList {
//    var movieCode: String
//    var title: String
//    var rank: String
//    var audiCount: String
    var boxOffice: DailyBoxOfficeList
    var rating: String
    var imageUrl: String
}

class ViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var eventCollectionView: UICollectionView!
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    var selectedCategoryCell = 0
    var movieList: [MovieList] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureEventCollectionView()
        configureRoundView()
        fetchMovieData()
    }
    
    // MARK: - Configure UI
    func configureNavigationBar() {
        setNavigationBarItems()
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        navigationItem.backButtonTitle = ""
    }
    
    func configureEventCollectionView() {
        self.eventCollectionView.backgroundView?.backgroundColor = UIColor.clear
        self.eventCollectionView.backgroundColor = UIColor.clear
    }
    
    func configureRoundView() {
        roundView.layer.cornerRadius = 20
        roundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    // MARK: - Actions
    @IBAction func pressedMoreMovieButton() {
        print("Pressed More Movie Button")
    }
    
    @objc func pressedReservationButton() {
        guard let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieInfo") as? MovieInfoViewController else {
            return
        }
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: - Networking
    func fetchMovieData() {
        MovieInfo.shared.requestBoxofficeData { result in
            switch result {
            case .success(let data):
                let movieData = data.boxOfficeResult.dailyBoxOfficeList
                for movie in movieData {
//                    self.movieList.append(MovieList(movieCode: movie.movieCd, title: movie.movieNm, rank: movie.rank, audiCount: movie.audiCnt, rating: "", imageUrl: ""))
                    self.movieList.append(MovieList(boxOffice: movie, rating: "", imageUrl: ""))
                }
                self.movieCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}

// MARK: - UICollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == eventCollectionView {
            return 10
        } else if collectionView == categoryCollectionView {
            return category.count
        } else if collectionView == movieCollectionView {
            return movieList.count
        }
        return 0
    }
    
    // cellForItemAt
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
        } else if collectionView == movieCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellIdentifier, for: indexPath) as? HomeMovieCollectionViewCell else {
                return UICollectionViewCell()
            }
            let movie = movieList[indexPath.row]
            
            MovieInfo.shared.requestAdditionalMovieData(query: movie.boxOffice.movieNm) { result in
                switch result {
                case .success(let data):
                    self.movieList[indexPath.row].imageUrl = data.items[0].image
                    self.movieList[indexPath.row].rating = data.items[0].userRating
                    if let url = URL(string: data.items[0].image) {
                        cell.posterImageView.load(url: url)
                    } else {
                        print("Fail to load image url")
                    }
                    DispatchQueue.main.async {
                        cell.ratingLabel.text = data.items[0].userRating
                    }
                case .failure(let error):
                    print(error)
                }
            }
            
            cell.rankLabel.isHidden = selectedCategoryCell == 0 ? false : true
            cell.titleLabel.text = movie.boxOffice.movieNm
            cell.rankLabel.text = movie.boxOffice.rank
            cell.todayLabel.text = numberFormatter(number: movie.boxOffice.audiCnt) + "명"
            cell.reservationButton.addTarget(self, action: #selector(pressedReservationButton), for: .touchUpInside)
            return cell
        }
        
        
        return UICollectionViewCell()
        
    }
    
    // sizeForItemAt
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
            width = label.frame.width + 24
            height = 50
        } else if collectionView == movieCollectionView {
            width = 160
            height = 320
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            print(indexPath.row)
            guard let cell = collectionView.cellForItem(at: indexPath) as? HomeCategoryCollectionViewCell else { return }
            cell.configureSelectedStatus()
            selectedCategoryCell = indexPath.row
            movieCollectionView.reloadData()
        } else if collectionView == movieCollectionView {
            guard let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieInfo") as? MovieInfoViewController else {
                return
            }
            let movie = movieList[indexPath.row]
            nextViewController.movieData.movieCode = movie.boxOffice.movieCd
            nextViewController.movieData.rating = movie.rating
            nextViewController.movieData.imageUrl = movie.imageUrl
            nextViewController.movieData.audiCnt = movie.boxOffice.audiCnt
            nextViewController.movieData.audiAcc = movie.boxOffice.audiAcc
            nextViewController.movieData.audiChange = movie.boxOffice.audiChange
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
