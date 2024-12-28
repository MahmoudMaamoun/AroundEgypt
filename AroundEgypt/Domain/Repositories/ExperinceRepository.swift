//
//  ExperinceRepository.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//

import Combine

protocol ExperinceRepository {
    func fetchRecommendedExperience() -> AnyPublisher<[Experince],NetworkError>
//    func LikeExperince(id:String) -> AnyPublisher<Void,Error>
}
