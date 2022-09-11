//
//  AdditionalMovieInfo.swift
//  Week5
//
//  Created by 이서영 on 2022/09/12.
//

import Foundation

struct AdditionalMovieInfo: Codable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [Item]
}

struct Item: Codable {
    let title: String
    let link: String
    let image: String
    let subtitle, pubDate, director, actor: String
    let userRating: String
}
