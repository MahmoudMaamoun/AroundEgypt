//
//  APIClient.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case requestFaild(Error)
    case decodingFailed
}
class APIClient {
    
    func fetchExperince() -> AnyPublisher<[ExcperinceData],NetworkError> {
        guard let url = URL(string: "https://aroundegypt.34ml.com/api/v2/experiences?filter[recommended]=true") else {
            return Fail(error: .invalidURL)
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: ExcperienceResponse.self, decoder: JSONDecoder())
            .map{$0.data}
            .mapError { error in
                return error is URLError ? NetworkError.requestFaild(error) : NetworkError.decodingFailed
            }
            .eraseToAnyPublisher()
            
    }
}
