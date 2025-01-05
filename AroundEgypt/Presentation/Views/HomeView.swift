//
//  HomeView.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject  var viewModel: ExperinceViewModel
    @State private var showDetailView = false
    @State private var selectedExperience: Experince?
    @State private var showingDetailView = false

    var body: some View {
        NavigationStack {
            VStack(){
                HStack() {
                    Button {
                        
                    } label: {
                        Image("Menu")
                    }

                    SearchBar(text: $viewModel.searchText)

                    

                }.padding()
                if viewModel.searchText.isEmpty {
                    ScrollView {
                        VStack(alignment:.leading,spacing: 20) {
                            VStack(alignment:.leading) {
                                Text("Welcome!")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.leading)
                                
                                Text("Now you can explore any experience in 360 degrees and get all the details about it all in one place.")
                                    .font(.subheadline)
                                    .padding(.horizontal)
                            }
                            Text("Recommended Experiences")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.leading)
                            
                            ScrollView(.horizontal,showsIndicators: false) {
                                HStack(spacing:16){
                                    ForEach(viewModel.recommendedExperiences) { experince in
                                       
                                        ExperienceCard(experience: experince) {
                                                print("Selected experience: \(experince)")
                                            DispatchQueue.main.async {
                                                self.selectedExperience = experince
                                                self.showDetailView = true
                                            }
                                                
                                         }
                                                .frame(maxWidth: .infinity)
                                    }
                                }.padding(.horizontal)
                            }
                            
                            Text("Recent Experiences")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.leading)
                            
                            ForEach(viewModel.recentExperiences) { experince in
                                ExperienceCard(experience: experince){
                                    DispatchQueue.main.async {
                                        self.selectedExperience = experince
                                        self.showDetailView = true
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                            }
                            
                        }
                    }
                } else {
                    ScrollView() {
                        ForEach(viewModel.searchResultExperiences) { experince in
                            ExperienceCard(experience: experince){
                                DispatchQueue.main.async {
                                    self.selectedExperience = experince
                                    self.showDetailView = true
                                }
                            }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .onChange(of: selectedExperience) { newValue in
                print("Selected experience changed: \(String(describing: newValue))")
            }
            
        }
        .sheet(isPresented: $showDetailView) {
            if let selectedExperience = selectedExperience {
                let expRepo = ExcpereinceRepositoryImp(apiClient: APIClient())
                let fetchSelectedExperinceUseCase = FetchSingleExcperinceUseCase(experinceRepository: expRepo)
                let likeExperinceUseCase = LikeExperinceUseCase(experinceRepository: expRepo)
                
                let vm = ExperienceDetailViewModel(singleExperince: selectedExperience, singleExperinceUseCase: fetchSelectedExperinceUseCase, likeExperinceUseCase: likeExperinceUseCase)
                ExperienceDetailView(viewModel:vm)
                    .onAppear() {
                        print("selected Experince is \(selectedExperience)")
                    }
            }
        }
    }
}
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Search", text: $text, onCommit: {
            // Trigger search
        })
       
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.horizontal)
    }
}

#Preview {
    let mockRepository = MockExperinceRepository()
    let viewModel = ExperinceViewModel(fetchRecommendedExperinceUseCase: FetchRecommendedExperinceUseCase(experinceRepository: mockRepository), fetchRecentExperince: FetchRecentExcperinceUseCase(experinceRepository: mockRepository), searchExperinceUseCase: SearchExperinceUseCase(experinceRepository: mockRepository))
    
    HomeView(viewModel: viewModel)
}
