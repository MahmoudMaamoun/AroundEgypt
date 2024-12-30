//
//  FetchRecentExcperinceUseCase.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 29/12/2024.
//

import Combine

class FetchRecentExcperinceUseCase : UseCase {
    private let experinceRepository :ExperinceRepository
    
    init(experinceRepository: ExperinceRepository) {
        self.experinceRepository = experinceRepository
    }
    func excute() -> AnyPublisher<[Experince],NetworkError> {
        return experinceRepository.fetchRecentExperience()
    }
}
