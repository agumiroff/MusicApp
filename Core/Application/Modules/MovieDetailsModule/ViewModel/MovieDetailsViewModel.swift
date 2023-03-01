//
//  ViewModel.swift
//  MusicApp
//
//  Created by G G on 11.01.2023.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    @Published var selectedTrack: Int = 0
    @Published var isPresented: Bool = false
    @Published var router: RouterProtocol
    @Published var movieData: MovieDataModel
    @Published var trackData = [TrackData.Track]()
    private var networkService: NetworkService
    
    init(router: RouterProtocol,
         movieData: MovieDataModel,
         networkService: NetworkService)
    {
        self.router = router
        self.movieData = movieData
        self.networkService = networkService
        
        networkService.searchTrack(completion: { [weak self] trackData in
            self?.trackData = trackData ?? []
        }, movieName: movieData.title)
    }
    
    func selectTrack(index: Int) {
        self.selectedTrack = index
    }
    
}
