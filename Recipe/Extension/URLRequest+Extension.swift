//
//  URLRequest+Extension.swift
//  Recipe
//
//  Created by Roshan sah on 22/11/20.
//

import Foundation

extension URLRequest {

    // MARK: - HTTP Methods
    
    enum HTTPMethod: String {
        case GET
        case POST

        var httpRawValue: String {
            switch self {
            case .GET:
                return self.rawValue
            case .POST:
                return self.rawValue
            }
        }
    }

    // MARK: - URL

    enum URLString: String {
        case recipe = "https://s3-ap-southeast-1.amazonaws.com/he-public-data/reciped9d7b8c.json"

        var url: URL {
            switch self {
            case .recipe:
                return URL(string: self.rawValue)!

            }
        }
    }

    // MARK: - Initilalizers

    init(forHttpMethod httpMethod: HTTPMethod, forAssociatedURL urlString: URLString) {
        self.init(url: urlString.url)
        self.httpMethod = httpMethod.httpRawValue
    }
}
