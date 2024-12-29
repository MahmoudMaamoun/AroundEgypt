//
//  ExperinceViewModel.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//
import Foundation
import Combine

class ExperinceViewModel:ObservableObject {
    @Published var experiences: [Experince] = []
    @Published var error: NetworkError?
    
    private let fetchRecommendedExperinceUseCase: FetchExperinceUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(fetchRecommendedExperinceUseCase: FetchExperinceUseCase) {
        self.fetchRecommendedExperinceUseCase = fetchRecommendedExperinceUseCase
        self.fetchRecommendedExperince()
    }
    
    private func fetchRecommendedExperince(){
        fetchRecommendedExperinceUseCase.excute()
            .sink(receiveCompletion: { completioin in
                switch completioin {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error
                }
            }) { excperinces in
                DispatchQueue.main.async {
                    self.experiences = excperinces
                }
            }
            .store(in: &cancellables)
    }
}
