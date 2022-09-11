//
//  DetailMovieInfo.swift
//  Week5
//
//  Created by 이서영 on 2022/09/12.
//

import Foundation

struct DetailMovieInfo: Codable {
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Codable {
    let movieInfo: MovieData
    let source: String
}

struct MovieData: Codable {
    let movieCd, movieNm, movieNmEn, movieNmOg: String
    let showTm, prdtYear, openDt, prdtStatNm: String
    let typeNm: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]
    let staffs: [Staff]
}

// MARK: - Actor
struct Actor: Codable {
    let peopleNm, peopleNmEn, cast, castEn: String
}

// MARK: - Audit
struct Audit: Codable {
    let auditNo, watchGradeNm: String
}

// MARK: - Company
struct Company: Codable {
    let companyCd, companyNm, companyNmEn, companyPartNm: String
}

// MARK: - Director
struct Director: Codable {
    let peopleNm, peopleNmEn: String
}

// MARK: - Genre
struct Genre: Codable {
    let genreNm: String
}

// MARK: - Nation
struct Nation: Codable {
    let nationNm: String
}

// MARK: - ShowType
struct ShowType: Codable {
    let showTypeGroupNm, showTypeNm: String
}

// MARK: - Staff
struct Staff: Codable {
    let peopleNm, peopleNmEn, staffRoleNm: String
}
