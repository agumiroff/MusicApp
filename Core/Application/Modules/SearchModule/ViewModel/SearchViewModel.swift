//
//  SearchModel.swift
//  MusicApp
//
//  Created by G G on 21.12.2022.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var movieDataArray = [MovieDataModel]()
    var router: RouterProtocol
    var networkService: NetworkService
    
    init(movieDataArray: [MovieDataModel] = [MovieDataModel](),
         router: RouterProtocol,
         networkService: NetworkService)
    {
        self.movieDataArray = movieDataArray
        self.router = router
        self.networkService = networkService
    }
    
    func searchMovie(movieName: String) {
        networkService.searchMovie(movieName: movieName,
                                   completion: { [weak self] movieDataArray in
            self?.movieDataArray = movieDataArray ?? []
        })
    }
}
