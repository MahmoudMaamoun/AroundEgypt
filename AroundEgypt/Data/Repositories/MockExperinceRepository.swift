//
//  MockExperince.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//

import Combine

class MockExperinceRepository : ExperinceRepository {
    func fetchRecommendedExperience() -> AnyPublisher<[Experince], NetworkError> {
        let mockExperiences = [
            Experince(id: "MOCKID1", title: "Luxor", image: "placeholder", recommended: true, likesCount: 600, viewsCount: 629, isLiked: true)
                ]
                return Just(mockExperiences)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
    }
    
    
}
