//
//  MovieInfoViewController.swift
//  Week5
//
//  Created by 이서영 on 2022/09/11.
//

import UIKit

class MovieInfoViewController: UIViewController {
    
    // MARK: - Properties
    struct Movie {
        var movieCode: String
        var rating: String
        var imageUrl: String
        var audiAcc: String
        var audiCnt: String
        var audiChange: String
    }
    
    var movieData = Movie(movieCode: "", rating: "", imageUrl: "", audiAcc: "", audiCnt: "", audiChange: "")
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var openDateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var gradeInfoLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var audiAccLabel: UILabel!
    @IBOutlet weak var audiCntLabel: UILabel!
    @IBOutlet weak var audiChangeLabel: UILabel!

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureLabelText()
        fetchDetailMovieInfo()
    }
    
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: nil, action: nil)
        navigationController!.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.backward")
        navigationController!.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward")
    }
    
    func configureLabelText() {
        ratingLabel.text = movieData.rating
        if let url = URL(string: movieData.imageUrl) {
            posterImageView.load(url: url)
        }
        audiCntLabel.text = numberFormatter(number: movieData.audiCnt)
        audiAccLabel.text = numberFormatter(number: movieData.audiAcc)
        audiChangeLabel.text = "\(movieData.audiChange)%"
        if let firstChar = movieData.audiChange.first {
            audiChangeLabel.textColor = firstChar == "-" ? .blue : .red
        }
    }
    
    // MARK: - Networking
    func fetchDetailMovieInfo() {
        MovieInfo.shared.requestDetailMovieData(movieCode: movieData.movieCode) { result in
            switch result {
            case .success(let data):
                let movie = data.movieInfoResult.movieInfo
                var genre = "", actors = ""
                for data in movie.genres {
                    genre += "\(data.genreNm) "
                }
                for i in 0...5 {
                    if i >= movie.actors.count {
                        break
                    }
                    actors += "\(movie.actors[i].peopleNm) "
                }
                DispatchQueue.main.async {
                    self.titleLabel.text = movie.movieNm
                    self.gradeLabel.text = movie.audits[0].watchGradeNm
                    self.gradeInfoLabel.text = movie.audits[0].watchGradeNm
                    self.openDateLabel.text = movie.openDt
                    self.typeLabel.text = movie.typeNm
                    self.genreLabel.text = genre
                    self.directorLabel.text = movie.directors[0].peopleNm
                    self.actorsLabel.text = actors
                    print("======")
                    print(movie.directors[0].peopleNm)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}
