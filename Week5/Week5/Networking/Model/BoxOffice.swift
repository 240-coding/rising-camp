//
//  BoxOfficeResult.swift
//  Week5
//
//  Created by 이서영 on 2022/09/11.
//

import Foundation

struct BoxOffice: Codable {
    let boxOfficeResult: BoxOfficeResult
}
struct BoxOfficeResult: Codable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Codable {
    let rnum, rank, rankInten: String
    let rankOldAndNew: String
    let movieCd, movieNm: String
    let openDt: String
    let salesAmt, salesShare, salesInten, salesChange, salesAcc: String
    let audiCnt, audiInten, audiChange, audiAcc: String
    let scrnCnt, showCnt: String
}
