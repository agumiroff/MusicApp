//
//  NetworkService.swift
//  MusicApp
//
//  Created by G G on 08.12.2022.
//

import UIKit
import Alamofire

struct Constants {
    static let API_KEY = "4f77076135e01316b0dfdbec9dd54d3b"
    static let baseURL = "https://api.themoviedb.org"
    static let arrayOfCalls: [String] = ["\(Constants.baseURL)/3/trending/movie/week?api_key=\(Constants.API_KEY)",
                                         "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)",
                                         "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)",
                                         "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)"]
}

protocol NetworkServiceProtocol: AnyObject {
    func getCategoriedMovies(completion: @escaping ([MovieDataModel]?) -> Void)
    func searchMovie(movieName: String, completion: (@escaping ([MovieDataModel]?) -> Void))
    func searchTrack(completion: (@escaping ([TrackData.Track]?) -> Void), movieName: String)
}

class NetworkService: NetworkServiceProtocol {
    
    
    func getCategoriedMovies(completion: @escaping ([MovieDataModel]?) -> Void) {
        for call in Constants.arrayOfCalls {
            guard let url = URL(string: call)
            else { return }
            
            let parameters = ["language":"en-US",
                              "page":"1"]
            let request = AF.request(url, parameters: parameters)
            request.responseDecodable(of: ApiCallResultModel.self) { response in
                switch response.result
                {
                case .success:
                    guard let data = response.value else { return }
                    completion(data.results)
                case .failure:
                    print("error \(String(describing: response.error?.localizedDescription))")
                    completion(nil)
                }
            }
        }
    }
    
    func searchMovie(movieName: String, completion: (@escaping ([MovieDataModel]?) -> Void)) {
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)")
        else { return }
        
        let parameters = ["language":"en-US",
                          "page":"1",
                          "include_adult":"false",
                          "query": movieName]
        
        let request = AF.request(url, parameters: parameters)
        request.responseDecodable(of: ApiCallResultModel.self) { response in
            switch response.result
            {
            case .success:
                guard let data = response.value else { return }
                completion(data.results)
            case .failure:
                print("error \(String(describing: response.error?.localizedDescription))")
                completion(nil)
            }
        }
    }
    
    func searchTrack(completion: (@escaping ([TrackData.Track]?) -> Void), movieName: String) {
        guard let url = URL(string: "https://itunes.apple.com/search")
        else { return }
        
        let parameters = ["term": movieName,
                          "limit": "10",
                          "media": "music"]
        
        let request = AF.request(url, parameters: parameters)
        request.responseDecodable(of: TrackData.TrackResult.self) { response in
            switch response.result
            {
            case .success:
                guard let data = response.value else { return }
                completion(data.results)
            case .failure:
                print("error \(String(describing: response.error?.localizedDescription))")
                completion(nil)
            }
        }
    }
}

