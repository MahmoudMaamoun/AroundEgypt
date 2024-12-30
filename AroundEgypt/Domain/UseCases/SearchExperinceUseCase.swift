//
//  SearchExperinceUseCase.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 30/12/2024.
//

import Combine

class SearchExperinceUseCase {
    private let experinceRepository :ExperinceRepository
    
    init(experinceRepository: ExperinceRepository) {
        self.experinceRepository = experinceRepository
    }
    func excute(searchText:String) -> AnyPublisher<[Experince], NetworkError> {
        return experinceRepository.searchForExperience(searchText: searchText)
    }
    
}
