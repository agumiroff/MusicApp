//
//  MovieModel.swift
//  MusicApp
//
//  Created by G G on 08.12.2022.
//

import UIKit

struct ApiCallResultModel: Decodable {
    let results: [MovieDataModel]
}

struct MovieDataModel: Decodable, Identifiable{
    var poster_path: String?
    var adult: Bool?
    var overview: String?
    var release_date: String?
    var id: Int?
    var original_title: String?
    var original_language: String?
    var title: String
    var backdrop_path: String?
    var popularity: Double?
    var vote_count: Int?
    var video: Bool?
}
