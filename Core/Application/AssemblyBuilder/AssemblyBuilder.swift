//
//  AssemblyBuilder.swift
//  MusicApp
//
//  Created by G G on 06.12.2022.
//

import UIKit
import SwiftUI

protocol AssemblyBuilderProtocol {
    func buildMainModule(router: RouterProtocol) -> MainModule
    func buildFavoritesModule() -> UIViewController
    func buildSearchModule(router: RouterProtocol) -> SearchModule
    func buildSettingsModule() -> UIViewController
    func buidMovieDetailsModule(router: RouterProtocol, movieData: MovieDataModel) -> MovieDetailsModule
    func buildTrackDetailsModule(router: RouterProtocol,
                                 trackData: [TrackData.Track],
                                 movieData: MovieDataModel,
                                 trackIndex: Int) -> TrackDetailsModule
}

class AssemblyBuilder: AssemblyBuilderProtocol {
       
    func buildMainModule(router: RouterProtocol) -> MainModule {
        let mainModule = MainModule()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: mainModule,
                                      router: router, networkSerice: networkService)
        mainModule.presenter = presenter
        mainModule.router = router
        return mainModule
    }
    
    func buildFavoritesModule() -> UIViewController {
        let mainModule = MainModule()
        return mainModule
    }
    
    func buildSearchModule(router: RouterProtocol) -> SearchModule {
        let networkService = NetworkService()
        let viewModel = SearchViewModel(router: router, networkService: networkService)
        let searchModule = SearchModule(viewModel: viewModel)
        
        return searchModule
    }
    
    func buildSettingsModule() -> UIViewController {
        let mainModule = MainModule()
        return mainModule
    }
    
    func buidMovieDetailsModule(router: RouterProtocol, movieData: MovieDataModel) -> MovieDetailsModule {
        let networkService = NetworkService()
        let viewModel = MovieDetailsViewModel(router: router,
                                              movieData: movieData,
                                              networkService: networkService)
        let movieDetailModule = MovieDetailsModule(viewModel: viewModel)
        return movieDetailModule
    }
    
    func buildTrackDetailsModule(router: RouterProtocol,
                                 trackData: [TrackData.Track],
                                 movieData: MovieDataModel,
                                 trackIndex: Int) -> TrackDetailsModule {
        
        let viewModel = TrackDetailsViewModel(movieData: movieData,
                                              trackData: trackData,
                                              trackIndex: trackIndex)
        let view = TrackDetailsModule(viewModel: viewModel)
        
        return view
    }
}
