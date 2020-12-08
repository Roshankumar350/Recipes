//
//  URLSession+Extension.swift
//  Recipe
//
//  Created by Roshan sah on 22/11/20.
//

import Foundation
import Combine

// MARK: - Error
enum APIError: Error, LocalizedError {
    case unKnown
    case apiError(reason: String)
}

extension APIError {
    var errorDescription: String? {
        switch self {
        case .unKnown:
            return "Unknown Error"
        case .apiError(reason: let reason):
            return reason
        }
    }
}

extension URLSession {

    // MARK: - HTTP Methods
    enum HTTPMethods: String {
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

    // MARK: - Behaviour
    
    func callingEndPoint(forRequest request: URLRequest) -> AnyPublisher<Data, APIError> {

        return self.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw APIError.unKnown
                }
                return data
            }
            .mapError { error in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError.apiError(reason: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
}
