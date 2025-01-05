//
//  ExperinceViewModel.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//
import Foundation
import Combine

class ExperinceViewModel:ObservableObject {
    @Published var recommendedExperiences: [Experince] = []
    @Published var recentExperiences: [Experince] = []
    @Published var searchResultExperiences: [Experince] = []
    @Published var searchText:String = ""
    @Published var error: NetworkError?
    
    private let fetchRecommendedExperinceUseCase: FetchRecommendedExperinceUseCase
    private let fetchRecentExperinceUseCase: FetchRecentExcperinceUseCase
    private let searchExperinceUseCase: SearchExperinceUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(fetchRecommendedExperinceUseCase: FetchRecommendedExperinceUseCase,fetchRecentExperince:FetchRecentExcperinceUseCase,searchExperinceUseCase: SearchExperinceUseCase) {
        self.fetchRecommendedExperinceUseCase = fetchRecommendedExperinceUseCase
        self.fetchRecentExperinceUseCase = fetchRecentExperince
        self.searchExperinceUseCase = searchExperinceUseCase
        
        start()
        // listen for changes in searchText
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates() // avoid dublicated requests
            .sink {[weak self] searchText in
                self?.fetchExperinceForSearch(searchtext: searchText)
            }
            .store(in: &cancellables)
    }
    
    private func start() {
        self.fetchRecommendedExperince()
        self.fetchRecentExperince()
    }
    private func fetchRecommendedExperince(){
        fetchRecommendedExperinceUseCase.excute()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error
                }
            }) { excperinces in
                DispatchQueue.main.async {
                    self.recommendedExperiences = Array(Set(excperinces))
                }
            }
            .store(in: &cancellables)
    }
    
    private func fetchRecentExperince() {
        fetchRecentExperinceUseCase.excute()
            .sink(receiveCompletion: { completioin in
                switch completioin {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error
                }
            }) { excperinces in
                DispatchQueue.main.async {
                    self.recentExperiences = Array(Set(excperinces))
                }
            }
            .store(in: &cancellables)

    }
    
    private func fetchExperinceForSearch(searchtext:String) {
        searchExperinceUseCase.excute(searchText: searchtext)
            .sink(receiveCompletion: { completioin in
                switch completioin {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error
                }
            }) { excperinces in
                DispatchQueue.main.async {
                    self.searchResultExperiences = Array(Set(excperinces))
                }
            }
            .store(in: &cancellables)

    }
    
   
}
