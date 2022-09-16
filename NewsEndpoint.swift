//
//  NewsEndpoint.swift
//  Mnemo
//
//  Created by Ana on 11/9/22.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}

enum NewsAPI {
    case getNews
}

extension NewsAPI: APIBuilder {

    var baseUrl: URL {
        switch self {
        case .getNews:
            return URL(string: "https://newsapi.org/v2/top-headlines?q=dementia&apiKey=e0908317b3394d3d819835f3a2d0f1a2")!
        }
    }
    
    var path: String {
        switch self {
        case .getNews:
            return ""

        }
    }
    
    var urlRequest: URLRequest {
        switch self {
        case .getNews:
            return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
        }
        }
    }
