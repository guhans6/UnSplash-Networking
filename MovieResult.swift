//
//  MovieResult.swift
//  UnSplash Networking
//
//  Created by guhan-pt6208 on 15/12/22.
//

import Foundation

// MARK: - Welcome
struct Movie: Decodable {
    let search: [Search]
    let totalResults: String
    let response: String
}

// MARK: - Search
struct Search: Decodable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
}

