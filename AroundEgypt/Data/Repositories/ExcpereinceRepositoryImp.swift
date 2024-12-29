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
        let fetchRequest: NSFetchRequest<ExcperinceEntity> = ExcperinceEntity.fetchRequest()
              
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
                      return self.apiClient.fetchExperince()
                                 .map { experienceData in
                                     experienceData.map{Experince(data: $0)}
                                 }
                                 .handleEvents(receiveOutput: { [weak self] experinces in
                                     self?.cacheExxperinces(experinces: experinces)
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
    
//    func LikeExperince(id: String) -> AnyPublisher<Void, any Error> {
//        return apiClient.
//    }
    
    private func cacheExxperinces(experinces:[Experince]) {
        for experince in experinces {
            let entity = ExcperinceEntity(context: context)
            entity.id = experince.id
            entity.title = experince.title
            entity.imageURL = experince.image
            entity.isLiked = experince.isLiked ?? false
            entity.likesCount = Int32(experince.likesCount)
            entity.numOfViews = Int32(experince.viewsCount)
            entity.recommended = experince.recommended
        }
        do {
            try context.save()
        } catch {
            print("Faild to save experince \(error)")
        }
    }
    
    
}
