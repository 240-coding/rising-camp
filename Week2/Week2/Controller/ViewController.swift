//
//  ViewController.swift
//  Week2
//
//  Created by 이서영 on 2022/08/14.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    private let bannerImages = ["banner1", "banner2", "banner3", "banner4"]

    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var bannerCollectionView: UICollectionView!
    @IBOutlet var orderStatusImageView: UIImageView!
    @IBOutlet var orderImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        configureNavigationBar()
        pageControl.addTarget(self, action: #selector(pageValueDidChanged), for: .valueChanged)
        
        let orderStatusTapGesture = UITapGestureRecognizer(target: self, action: #selector(orderStatusPressed))
        orderStatusImageView.addGestureRecognizer(orderStatusTapGesture)
        orderStatusImageView.isUserInteractionEnabled = true
        
        let orderTapGesture = UITapGestureRecognizer(target: self, action: #selector(orderPressed))
        orderImageView.addGestureRecognizer(orderTapGesture)
        orderImageView.isUserInteractionEnabled = true
        
        bannerTimer()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pageControl.currentPage = 0
        bannerCollectionView.scrollToItem(at: NSIndexPath(item: pageControl.currentPage, section: 0) as IndexPath, at: .right, animated: true)
    }
    
    func configureNavigationBar() {
        let logoImageView = UIImageView(image: UIImage(named: "logo"))
        logoImageView.contentMode = .scaleAspectFit

        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 30),
            logoImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
                
        self.navigationItem.titleView = logoImageView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "EN", style: .plain, target: self, action: nil)
        
        navigationItem.backButtonTitle = ""
    }
    
    
    // MARK: - Actions
    @objc func pageValueDidChanged() {
        let indexPath = IndexPath(row: pageControl.currentPage, section: 0)
        bannerCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
    @objc func orderStatusPressed() {
        guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "OrderViewController") as? OrderViewController else {
            return
        }
        nextViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func orderPressed() {
        guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else {
            return
        }
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: - Banner Timer
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    func bannerMove() {
        if pageControl.currentPage == bannerImages.count-1 {
            bannerCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
            pageControl.currentPage = 0
            return
        }
        pageControl.currentPage += 1
        bannerCollectionView.scrollToItem(at: NSIndexPath(item: pageControl.currentPage, section: 0) as IndexPath, at: .right, animated: true)
    }
}

// MARK: - Banner Collection View and Page Control

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.frame.size.width != 0 {
            let value = (scrollView.contentOffset.x / scrollView.frame.width)
            pageControl.currentPage = Int(round(value))
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = bannerImages.count
        return bannerImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as? BannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureImageView(image: bannerImages[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
