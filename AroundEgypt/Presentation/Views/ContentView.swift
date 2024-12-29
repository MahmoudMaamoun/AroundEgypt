//
//  ContentView.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    private let apiClient:APIClient = APIClient()
    
    var body: some View {
       let experinceRepository:ExperinceRepository = {
            return ExcpereinceRepositoryImp(apiClient: apiClient)
        }()
        let fetchRecommendedExperince = FetchExperinceUseCase(experinceRepository: experinceRepository)
        
        let experinceViewModel = ExperinceViewModel(fetchRecommendedExperinceUseCase: fetchRecommendedExperince)

        HomeView(viewModel: experinceViewModel)
    }
    

}


#Preview {
//    let mockRepository = MockExperinceRepository()
//    let viewModel = ExperinceViewModel(fetchRecommendedExperinceUseCase: FetchExperinceUseCase(experinceRepository: mockRepository))
//    
    ContentView().environment(\.managedObjectContext, CoreDataStack.shared.persistentContainer.viewContext)
}
