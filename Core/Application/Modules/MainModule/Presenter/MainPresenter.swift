//
//  MainPresenter.swift
//  MusicApp
//
//  Created by G G on 08.12.2022.
//

import UIKit

protocol MainModuleProtocol: AnyObject {
    func success(movieData: [MovieDataModel])
    func failure()
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainModuleProtocol, router: RouterProtocol, networkSerice: NetworkServiceProtocol)
    func viewDidLoad()
}

class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainModuleProtocol!
    var router: RouterProtocol
    var networkService: NetworkServiceProtocol
    
    required init(view: MainModuleProtocol, router: RouterProtocol, networkSerice: NetworkServiceProtocol) {
        self.view           = view
        self.router         = router
        self.networkService = networkSerice
    }
    
    func viewDidLoad() {
        networkService.getCategoriedMovies {[weak self] callResult in
            self?.view.success(movieData: callResult ?? [])
        }
    }
    
    
}

