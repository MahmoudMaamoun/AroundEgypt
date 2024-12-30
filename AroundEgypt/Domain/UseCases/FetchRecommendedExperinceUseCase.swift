//
//  FetchExperinceUseCase.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//
import Combine

class FetchRecommendedExperinceUseCase {
    private let experinceRepository :ExperinceRepository
    
    init(experinceRepository: ExperinceRepository) {
        self.experinceRepository = experinceRepository
    }
    
    func excute() -> AnyPublisher<[Experince],NetworkError> {
        return experinceRepository.fetchRecommendedExperience()
    }
}
