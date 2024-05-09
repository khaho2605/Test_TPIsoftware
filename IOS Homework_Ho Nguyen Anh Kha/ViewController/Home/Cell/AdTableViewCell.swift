//
//  AdTableViewCell.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 7/5/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Timer for auto change ad image
    private var timer: Timer?
    private var currentIndex: Int = 0
    private let timeInterval: Double = 3
    
    private var adBanners = [AdBanner]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        setupCollectionView()
//        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(scrollNext), userInfo: nil, repeats: true)
    }
    
    func updateUI(with listAdBanner: [AdBanner]) {
        adBanners = listAdBanner
        pageControl.numberOfPages = adBanners.count
        if adBanners.count > 0 {
            collectionView.reloadData()
        }
    }
    
    @objc private func scrollNext(){
        if(currentIndex < adBanners.count - 1){
            currentIndex = currentIndex + 1;
            
        } else if (currentIndex == adBanners.count - 1) {
            currentIndex = 0;
        }
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .left, animated: true)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AdImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AdImageCollectionViewCell")
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension AdTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adBanners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdImageCollectionViewCell", for: indexPath) as! AdImageCollectionViewCell
        cell.updateImage(with: adBanners[indexPath.row].linkUrl)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        currentIndex = Int(offSet + horizontalCenter) / Int(width)
        pageControl.currentPage = currentIndex
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension AdTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
}
