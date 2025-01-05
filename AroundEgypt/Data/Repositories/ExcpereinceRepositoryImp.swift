//
//  ExcpereinceRepositoreImp.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//

import Combine
import CoreData

class ExcpereinceRepositoryImp : ExperinceRepository {
   
    private let apiClient:APIClient
    private let context: NSManagedObjectContext

    init(apiClient: APIClient) {
        self.apiClient = apiClient
        self.context = CoreDataStack.shared.context
    }
    
    func fetchRecommendedExperience() -> AnyPublisher<[Experince],NetworkError> {
        
        // Fetch from Core Data First
        let fetchRequest: NSFetchRequest<RecommendedExcperince> = RecommendedExcperince.fetchRequest()
              
              return Future { promise in
                  do {
                      let cachedExperiences = try self.context.fetch(fetchRequest)
                      let experiences = cachedExperiences.map { Experince(data: $0) }
                      promise(.success(experiences))
                  } catch {
                      promise(.failure(NetworkError.decodingFailed))
                  }
              }
              .flatMap { cachedExperinces -> AnyPublisher<[Experince],NetworkError> in
                  
                  if cachedExperinces.isEmpty{
                      return self.apiClient.fetchPopularExperince()
                                 .map { experienceData in
                                     experienceData.map{Experince(data: $0)}
                                 }
                                 .handleEvents(receiveOutput: { [weak self] experinces in
                                     self?.cacheRecommendedExperinces(experinces: experinces)
                                 })
                                 .mapError { error -> NetworkError in
                                     return error
                                 }
                                 .eraseToAnyPublisher()
                  } else {
                      return Just(cachedExperinces)
                          .setFailureType(to: NetworkError.self)
                          .eraseToAnyPublisher()
                  }
              }
              .eraseToAnyPublisher()
//
    }
    
    func fetchRecentExperience() -> AnyPublisher<[Experince], NetworkError> {
        let fetchRequest: NSFetchRequest<RecentExperince> = RecentExperince.fetchRequest()
              
              return Future { promise in
                  do {
                      let cachedExperiences = try self.context.fetch(fetchRequest)
                      let experiences = cachedExperiences.map { Experince(data: $0) }
                      promise(.success(experiences))
                  } catch {
                      promise(.failure(NetworkError.decodingFailed))
                  }
              }
              .flatMap { cachedExperinces -> AnyPublisher<[Experince],NetworkError> in
                  
                  if cachedExperinces.isEmpty{
                      return self.apiClient.fetchRecentExperince()
                                 .map { experienceData in
                                     experienceData.map{Experince(data: $0)}
                                 }
                                 .handleEvents(receiveOutput: { [weak self] experinces in
                                     self?.cacheRecentExperinces(experinces: experinces)
                                 })
                                 .mapError { error -> NetworkError in
                                     return error
                                 }
                                 .eraseToAnyPublisher()
                  } else {
                      return Just(cachedExperinces)
                          .setFailureType(to: NetworkError.self)
                          .eraseToAnyPublisher()
                  }
              }
              .eraseToAnyPublisher()
    }

    func searchForExperience(searchText: String) -> AnyPublisher<[Experince], NetworkError> {
       
        return self.apiClient.searchExperince(searchText: searchText)
                                 .map { experienceData in
                                     experienceData.map{Experince(data: $0)}
                                 }
                                 .handleEvents(receiveOutput: { [weak self] experinces in
                                     self?.cacheRecentExperinces(experinces: experinces)
                                 })
                                 .mapError { error -> NetworkError in
                                     return error
                                 }
                                 .eraseToAnyPublisher()
              
    }
    
    func fetchSingleExcperince(id:String) -> AnyPublisher<Experince, NetworkError> {
        return self.apiClient.fetchSingleExcperince(id: id)
            .map{ singleExcperinceData in
                return Experince(data: singleExcperinceData)
            }
            .handleEvents(receiveOutput: { experince in
                print("Single Excperince Fetched \(experince.title)")
            })
            .mapError { error -> NetworkError in
                return error
            }
            .eraseToAnyPublisher()
    }
   
    func LikeExperince(id: String) -> AnyPublisher<Int, NetworkError> {
        return self.apiClient.likeAnExperince(id: id)
            .map{ id in
                return id
            }
            .eraseToAnyPublisher()
    }
    
    private func cacheRecommendedExperinces(experinces:[Experince]) {
        for experince in experinces {
            let fetchRequest:NSFetchRequest<RecommendedExcperince> = RecommendedExcperince.fetchRequest()
            
            fetchRequest.predicate = NSPredicate(format: "id == %@", experince.id)
            do {
                let existingExperinces = try context.fetch(fetchRequest)
                if existingExperinces.isEmpty {
                    
                    // add item if it doesn't exist
                    let entity = RecommendedExcperince(context: context)
                    entity.id = experince.id
                    entity.title = experince.title
                    entity.imageURL = experince.image
                    entity.isLiked = experince.isLiked ?? false
                    entity.likesCount = Int32(experince.likesCount)
                    entity.numOfViews = Int32(experince.viewsCount)
                    entity.recommended = experince.recommended
                }
                
                else {
                    // update the exxisting entry if necessary
                    
                }
            } catch {
                print("error in fetching item in recommended experince \(error)")
            }
           
        }
        do {
            try context.save()
        } catch {
            print("Faild to save experince \(error)")
        }
    }

    private func cacheRecentExperinces(experinces:[Experince]) {
      
        for experince in experinces {
            let fetchRequest:NSFetchRequest<RecentExperince> = RecentExperince.fetchRequest()
            
            fetchRequest.predicate = NSPredicate(format: "id == %@", experince.id)
            do {
                let existingExperinces = try context.fetch(fetchRequest)
                if existingExperinces.isEmpty {
                    
                    let entity = RecentExperince(context: context)
                    entity.id = experince.id
                    entity.title = experince.title
                    entity.imageURL = experince.image
                    entity.isLiked = experince.isLiked ?? false
                    entity.likesCount = Int32(experince.likesCount)
                    entity.numOfViews = Int32(experince.viewsCount)
                    entity.recommended = experince.recommended
                }
            } catch {
                print("error happened in fetching recent item for check \(error) ")
            }
        }
        do {
            try context.save()
        } catch {
            print("Faild to save experince \(error)")
        }
    }

}
