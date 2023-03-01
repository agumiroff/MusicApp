//
//  SecondVC.swift
//  MusicApp
//
//  Created by G G on 10.12.2022.
//

import UIKit
import SnapKit

class SecondVC: UIViewController {
    var moviesData: MovieDataModel!
    
    let label: UILabel = {
        let text = UILabel()
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .brown
        view.addSubview(label)
        label.text = moviesData.title
        
        label.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}
