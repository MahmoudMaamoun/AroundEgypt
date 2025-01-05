//
//  ExperienceDetailView.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 30/12/2024.
//

import SwiftUI

struct ExperienceDetailView: View {
//    @State var selectedExperince:Experince
    @ObservedObject var viewModel: ExperienceDetailViewModel

    var body: some View {
        ScrollView() {
            VStack() {
                ZStack() {
                    AsyncImage(url: URL(string: viewModel.singleExperince.image)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width:UIScreen.main.bounds.width,height: 285)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 8.0))
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 8,x: 6,y: 8)
                    } placeholder: {
                        Image("placeholder")
                            .resizable()
                            .scaledToFill()
                            .frame(width:UIScreen.main.bounds.width,height: 285)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 8.0))
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 8,x: 6,y: 8)
                        
                    }
                    VStack(alignment:.center) {
                        HStack () {
                            if viewModel.singleExperince.recommended {
                                RecommendedView()
                            }
                            Spacer()
                            
                        }
                        .padding()
                        Spacer()
                        Button(action:{
                            
                        }) {
                            Text("Explore Now")
                                .foregroundStyle(.star)
                                .background(){
                                    RoundedRectangle(cornerRadius: 4)
                                        .frame(width: 152,height: 46)
                                        .foregroundStyle(.white)
//                                        .shadow(radius: 0.3)
                                }
                            
                        }
                        Spacer()
                        HStack () {
                            NumberOfView(numOfViews: viewModel.singleExperince.viewsCount)
                            Spacer()
                            Image("multiplepictures")
                                .resizable()
                                .frame(width: 21,height: 17.5)
                                .foregroundStyle(.white)
                        }
                        .padding()
                    }
                }
                VStack(alignment:.leading) {
                    HStack(spacing:16) {
                        Text(viewModel.singleExperince.title)
                            .font(.title2)
                            .fontWeight(.bold)
                       
                        Spacer()
                        
                        Button(action:{
                            
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .frame(width: 17,height: 17)
                                .foregroundStyle(.star)
                        }
                        Button(action:{
                            viewModel.likeAnExperince()
                        }) {
                            Image(systemName: "heart")
                                .resizable()
                                .frame(width: 20,height: 19)
                                .foregroundStyle(.star)
                        }
                        
                        Text("\(viewModel.singleExperince.likesCount)")
                            .font(.subheadline)
                        
                        
                    }
                    if let address = viewModel.singleExperince.location {
                        Text(address)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    Divider()
                    
                    Text("Description")
                        .font(.title)
                        .fontWeight(.bold)
                    if let overview = viewModel.singleExperince.overview {
                        Text(overview)
                            .font(.body)
                            .lineLimit(nil)
                    }
                    Spacer()
                }.padding()
            }
            .onAppear(){
                viewModel.fetchSingleExperince()
            }
        }
    }
}
//
//#Preview {
//    let exp = Experince(id: "MOCKID1", title: "Luxor", image: "placeholder", recommended: true, likesCount: 600, viewsCount: 629, isLiked: true)
//    ExperienceDetailView(selectedExperince: exp, viewModel: .init(singleExperince: exp, experinceRepo: MockExperinceRepository()))
//}
