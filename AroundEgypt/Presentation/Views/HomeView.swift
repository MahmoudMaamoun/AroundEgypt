//
//  HomeView.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject  var viewModel: ExperinceViewModel
    
    var body: some View {
        NavigationView {
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
                            ForEach(viewModel.experiences) { experince in
                                ExperienceCard(experience: experince)
                                    .frame(maxWidth: .infinity)
                            }
                        }.padding(.horizontal)
                    }

                }
            }
//            List(viewModel.experiences) { experince in
//                ExperienceCard(experience: experince)
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical,8)
//                    .listRowInsets(EdgeInsets())
//            }
//            .frame(maxWidth: .infinity)
//            .listRowSeparator(.hidden)

        }
    }
}

#Preview {
    let mockRepository = MockExperinceRepository()
    let viewModel = ExperinceViewModel(fetchRecommendedExperinceUseCase: FetchExperinceUseCase(experinceRepository: mockRepository))
    
    HomeView(viewModel: viewModel)
}
