//
//  Router.swift
//  MusicApp
//
//  Created by G G on 06.12.2022.
//

import UIKit
import SwiftUI

protocol RouterProtocol {
    func tabBarModulesSetup()
    func movieDetailsPageRoute(moviesData: MovieDataModel)
    func trackDetailsModule(trackData: [TrackData.Track],
                            movieData: MovieDataModel,
                            trackIndex: Int) -> TrackDetailsModule
}

class Router: RouterProtocol {
    
    
    let tabBarController: MainTabBarController
    var assemblyBuilder: AssemblyBuilderProtocol
    
    init(assemblyBuilder: AssemblyBuilderProtocol, tabBarController: MainTabBarController) {
        self.assemblyBuilder = assemblyBuilder
        self.tabBarController = tabBarController
    }
    
    func tabBarModulesSetup() {
        let mainModule   = assemblyBuilder.buildMainModule(router: self)
        let searchModule = assemblyBuilder.buildSearchModule(router: self)
        tabBarController.viewControllers = [
            generateVC(targetModule: mainModule, image: Resources.TabBar.Images.home!, moduleName: Resources.TabBar.Titles.home),
            generateVC(targetModule: UIHostingController(rootView: searchModule), image: Resources.TabBar.Images.home!, moduleName: Resources.TabBar.Titles.home),
            generateVC(targetModule: LibraryModule(), image: Resources.TabBar.Images.home!, moduleName: Resources.TabBar.Titles.home),
            generateVC(targetModule: SettingsModule(), image: Resources.TabBar.Images.home!, moduleName: Resources.TabBar.Titles.home),
        ]
    }
    
    func trackDetailsModule(trackData: [TrackData.Track], movieData: MovieDataModel, trackIndex: Int)->TrackDetailsModule {
        let trackDetailsModule = assemblyBuilder.buildTrackDetailsModule(
            router: self,
            trackData: trackData,
            movieData: movieData,
            trackIndex: trackIndex)
        print(trackIndex)
        return trackDetailsModule
    }
    
    func movieDetailsPageRoute(moviesData: MovieDataModel) {
        let detailsModule = UIHostingController(rootView: assemblyBuilder.buidMovieDetailsModule(router: self,
                                                                                                 movieData: moviesData))
        let navigationController = tabBarController.selectedViewController as! UINavigationController
        navigationController.pushViewController(detailsModule, animated: true)
    }
    
    func generateVC(targetModule: UIViewController,
                    image: UIImage,
                    moduleName: String) -> UIViewController {
        targetModule.tabBarItem.image = image
        targetModule.tabBarItem.title = moduleName
        targetModule.tabBarItem.imageInsets = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0) //Почему не работает?
        let controller = UINavigationController(rootViewController: targetModule)
        configureNavigationBar(navigationController: controller)
        return controller
    }
    
    func configureNavigationBar(navigationController: UINavigationController) {
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage   = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.tintColor     = UIColor.white
        navigationController.isNavigationBarHidden       = true
    }
}
