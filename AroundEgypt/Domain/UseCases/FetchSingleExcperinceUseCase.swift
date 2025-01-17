//
//  FetchSingleExcperinceUseCase.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 30/12/2024.
//

import Combine
class FetchSingleExcperinceUseCase {
    private let experinceRepository :ExperinceRepository
    
    init(experinceRepository: ExperinceRepository) {
        self.experinceRepository = experinceRepository
    }
    
    func excute(id:String) -> AnyPublisher<Experince,NetworkError> {
        return experinceRepository.fetchSingleExcperince(id: id)
    }
}
