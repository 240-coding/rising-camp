//
//  MovieInfo.swift
//  Week5
//
//  Created by 이서영 on 2022/09/11.
//

import Foundation
import Alamofire

struct MovieInfo {
    static let shared = MovieInfo()
    private let baseURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    private let key = "1a14a175b187448aa2bd9f778f29e45c"
    
    private init() { }
}

extension MovieInfo {
    func getTodayDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: Date())
    }
    func requestBoxofficeData(completion: @escaping (Result<BoxOffice, Error>) -> Void) {
        let parameters = ["key": key, "targetDt": "20220910"]
        AF.request(baseURL, method: .get, parameters: parameters)
            .responseDecodable(of: BoxOffice.self) { response in
                switch response.result {
                case .success(let response):
                    debugPrint(response)
                    completion(.success(response))
                case .failure(let response):
                    debugPrint(response)
                    completion(.failure(response))
                }
            }
    }
}
