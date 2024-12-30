//
//  LikeExperinceUseCase.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 30/12/2024.
//

import Combine

class LikeExperinceUseCase {
    
    private let experinceRepository :ExperinceRepository
    
    init(experinceRepository: ExperinceRepository) {
        self.experinceRepository = experinceRepository
    }
    func excute(id:String) -> AnyPublisher<Int,NetworkError> {
        return experinceRepository.LikeExperince(id: id)
    }
}
