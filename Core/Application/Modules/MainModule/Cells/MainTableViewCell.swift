//
//  MainTableViewCell.swift
//  MusicApp
//
//  Created by G G on 06.12.2022.
//

import UIKit
import SnapKit
import SDWebImage

class MainTableViewCell: UITableViewCell {
    
    static let reuseId = "MainTableViewCell"
    var router: RouterProtocol!
    var moviesData  = [MovieDataModel]()
    var cellHeight: Double!
    var cellWidth:  Double!
    var fontSize:   Double!
    var posterSide: Double!
    var section:    Int!
    
    
    var collectionView: UICollectionView = {
        let layout              = UICollectionViewFlowLayout()
        layout.scrollDirection  = .horizontal
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collection.backgroundColor  = .none
        layout.scrollDirection      = .horizontal
        collection.showsHorizontalScrollIndicator = false
        collection.register(CollectionViewCell.self,
                            forCellWithReuseIdentifier: CollectionViewCell.cellId)
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: MainTableViewCell.reuseId)
        backgroundColor = UIColor.clear
        setupCollectionView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellId,
                                                           for: indexPath) as? CollectionViewCell
        else { return UICollectionViewCell() }
        cell.configureCell(
            title: moviesData[indexPath.row].title,
            imageURL: moviesData[indexPath.row].poster_path ?? "",
            section: self.section, fontSize: self.fontSize)
        return cell
    }
    
    func setupCollectionView(){
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate   = self
        
        collectionView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        moviesData.count
    }
    
    func configureCollection(cellHeight: Double,
                             cellWidth: Double,
                             fontSize: Double,
                             section: Int,
                             router: RouterProtocol,
                             moviesData: [MovieDataModel]) {
        
        self.cellHeight = cellHeight
        self.cellWidth  = cellWidth
        self.fontSize   = fontSize
        self.section    = section
        self.router     = router
        self.moviesData = moviesData
        collectionView.reloadData()
    } // Правильно ли так передавать данные? Как передавать данные переменные через делегат?
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router.movieDetailsPageRoute(moviesData: moviesData[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}
