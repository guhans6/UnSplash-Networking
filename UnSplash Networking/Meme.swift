//
//  Meme.swift
//  UnSplash Networking
//
//  Created by guhan-pt6208 on 16/12/22.
//

import Foundation

// MARK: - Welcome
struct MemeResult: Codable {
    let success: Bool
    let data: MemeArray
}

// MARK: - DataClass
struct MemeArray: Codable {
    let memes: [Meme]
}

// MARK: - Meme
struct Meme: Codable {
    let id, name: String
    let url: String
    let width, height, captions: Int
}

