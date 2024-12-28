//
//  ExcpereinceRepositoreImp.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//

import Combine

class ExcpereinceRepositoreImp : ExperinceRepository {
   
    private let apiClient:APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchRecommendedExperience() -> AnyPublisher<[Experince],NetworkError> {
        
        return apiClient.fetchExperince()
            .map { experienceData in
                experienceData.map{Experince(data: $0)}
            }
            .mapError { error -> NetworkError in
                return error
            }
            .eraseToAnyPublisher()
    }
    
//    func LikeExperince(id: String) -> AnyPublisher<Void, any Error> {
//        return apiClient.
//    }
    
    
    
}
