//
//  ExperinceRepository.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//

import Combine

protocol ExperinceRepository {
    func fetchRecommendedExperience() -> AnyPublisher<[Experince],NetworkError>
    func fetchRecentExperience() -> AnyPublisher<[Experince],NetworkError>
    func searchForExperience(searchText:String) -> AnyPublisher<[Experince],NetworkError>
    func fetchSingleExcperince(id:String) -> AnyPublisher<Experince,NetworkError>
    func LikeExperince(id:String) -> AnyPublisher<Int,NetworkError>
}
