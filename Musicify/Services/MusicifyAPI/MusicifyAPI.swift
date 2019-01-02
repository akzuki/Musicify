//
//  MusicifyAPI.swift
//  Musicify
//
//  Created by Hai Phan on 02/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import Foundation
import Moya

enum MusicifyAPI: TargetType {
    case latestSongs
    
    var baseURL: URL {
        return URL(string: "http://localhost:3000")!
    }
    
    var path: String {
        switch self {
        case .latestSongs:
            return "/latestSongs"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .latestSongs:
            return .get
        }
    }
    
    var sampleData: Data {
        fatalError("Sample data is not available")
    }
    
    var task: Task {
        switch self {
        case .latestSongs:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
