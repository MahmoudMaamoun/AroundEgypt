//
//  MockExperince.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//

import Combine

class MockExperinceRepository : ExperinceRepository {
    func LikeExperince(id: String) -> AnyPublisher<Int, NetworkError> {
        return Just(3232)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
    
    
    func fetchSingleExcperince(id: String) -> AnyPublisher<Experince, NetworkError> {
        let exp = Experince(id: "MOCKID1", title: "Luxor", image: "placeholder", recommended: true, likesCount: 600, viewsCount: 629, isLiked: true, location: "Cairo Egypt",overview:"this is dec")
        return Just(exp)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func searchForExperience(searchText: String) -> AnyPublisher<[Experince], NetworkError> {
        let mockExperiences = [
            Experince(id: "MOCKID1", title: "Luxor", image: "placeholder", recommended: true, likesCount: 600, viewsCount: 629, isLiked: true, location: "Cairo Egypt",overview:"this is dec")
                ]
                return Just(mockExperiences)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
    }
    
    func fetchRecommendedExperience() -> AnyPublisher<[Experince], NetworkError> {
        let mockExperiences = [
            Experince(id: "MOCKID1", title: "Luxor", image: "placeholder", recommended: true, likesCount: 600, viewsCount: 629, isLiked: true, location: "Cairo Egypt",overview:"this is dec")
                ]
                return Just(mockExperiences)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
    }
    
    func fetchRecentExperience() -> AnyPublisher<[Experince], NetworkError> {
        let mockExperiences = [
            Experince(id: "MOCKID1", title: "Luxor", image: "placeholder", recommended: true, likesCount: 600, viewsCount: 629, isLiked: true, location: "Cairo Egypt",overview:"this is dec")
                ]
                return Just(mockExperiences)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
    }
    
}
