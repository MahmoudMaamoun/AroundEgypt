//
//  ExperienceDetailViewModel.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 30/12/2024.
//

import Combine
import Foundation
class ExperienceDetailViewModel:ObservableObject {
    
    @Published var singleExperince:Experince
    @Published var error: NetworkError?

    private let singleExperinceUseCase:FetchSingleExcperinceUseCase
    private let likeExperinceUseCase: LikeExperinceUseCase
    private var cancellable = Set<AnyCancellable>()

    
    init(singleExperince: Experince,singleExperinceUseCase:FetchSingleExcperinceUseCase,likeExperinceUseCase:LikeExperinceUseCase) {
        self.singleExperince = singleExperince
        self.likeExperinceUseCase = likeExperinceUseCase
        self.singleExperinceUseCase = singleExperinceUseCase
    }
    
    func fetchSingleExperince() {
        singleExperinceUseCase.excute(id: singleExperince.id)
            .sink { comp in
                switch comp {
                case .finished:
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.error = error
                    }
                }
            } receiveValue: {  experince in
                DispatchQueue.main.async {
                    self.singleExperince = experince
                }
            }
            .store(in: &cancellable)
//        repository.fetchSingleExcperince(id: singleExperince.id)
//            .sink { _ in
//                
//            } receiveValue: { [weak self] experince in
//                
//                self?.singleExperince = experince
//            }
//            .store(in: &cancellable)
    }
    
     func likeAnExperince() {
         likeExperinceUseCase.excute(id: singleExperince.id)
            .sink { comp in
                switch comp {
                case .finished:
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        print(error)
                        self.error = error
                    }
                }
            } receiveValue: { [weak self] numOfLikes in
                self?.singleExperince.likesCount = numOfLikes
            }
            .store(in: &cancellable)
    }
}
