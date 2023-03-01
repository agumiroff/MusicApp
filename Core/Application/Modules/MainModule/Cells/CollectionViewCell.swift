//
//  CollectionViewCell.swift
//  MusicApp
//
//  Created by G G on 07.12.2022.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    
    var fontSize: Double = 14
    static var cellId = "CollectionViewCell"
    
    let posterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = UIView.ContentMode.scaleAspectFill
        return image
    }()
    
    let movieName: UILabel = {
        let label           = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingMiddle
        label.textAlignment = .center
        label.textColor     = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        
    }
    
    func setupCell(fontSize: Double) {
        contentView.addSubview(posterImage)
        addSubview(movieName)
//
        posterImage.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(movieName.snp.top).offset(-14)
            
        }

        movieName.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(fontSize)
        }
    }
    
    func configureCell(title: String,
                       imageURL: String,
                       section: Int,
                       fontSize: Double)
    {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(imageURL)") else { return }
        movieName.text = title
        movieName.font = .robotoMedium(size: fontSize)
        posterImage.sd_setImage(with: url)
        self.posterImage.clipsToBounds = true
        self.posterImage.layer.cornerRadius = section == 0 ?
        self.frame.size.width/2 : self.frame.size.width/10
        setupCell(fontSize: fontSize)
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image = nil
        movieName.text    = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
