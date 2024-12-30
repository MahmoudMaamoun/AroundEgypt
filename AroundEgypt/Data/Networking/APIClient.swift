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
    
    func fetchPopularExperince() -> AnyPublisher<[ExcperinceData],NetworkError> {
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
    
    
    func fetchRecentExperince() -> AnyPublisher<[ExcperinceData],NetworkError> {
        guard let url = URL(string: "https://aroundegypt.34ml.com/api/v2/experiences") else {
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
    
    func searchExperince(searchText:String) -> AnyPublisher<[ExcperinceData],NetworkError> {
        guard let url = URL(string: "https://aroundegypt.34ml.com/api/v2/experiences?filter[title]=\(searchText)") else {
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
    
    func fetchSingleExcperince(id:String) -> AnyPublisher<ExcperinceData,NetworkError> {
        guard let url = URL(string: "https://aroundegypt.34ml.com/api/v2/experiences/\(id)/like") else {
            return Fail(error: .invalidURL)
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: SingleExcperienceResponse.self, decoder: JSONDecoder())
            .map{$0.data}
            .mapError { error in
                return error is URLError ? NetworkError.requestFaild(error) : NetworkError.decodingFailed
            }
            .eraseToAnyPublisher()
    }
    
    func likeAnExperince(id:String) -> AnyPublisher<Int,NetworkError> {
        guard let url = URL(string: "https://aroundegypt.34ml.com/api/v2/experiences/\(id)/like") else {
            return Fail(error: .invalidURL)
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .handleEvents(receiveOutput: { data in
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON Response: \(jsonString)")
                }
            })
            .decode(type: ExcperinceLikeResponse.self, decoder: JSONDecoder())
            .map(\.data)
            .mapError { error in
                return error is URLError ? NetworkError.requestFaild(error) : NetworkError.decodingFailed
            }
            .eraseToAnyPublisher()
        
    }
}
