//
//  ExperinceCard.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//

import SwiftUI

struct ExperienceCard: View {
    
    let experience: Experince
    var onSelect: () -> Void
    
    var body: some View {
        VStack() {
            ZStack() {
            
                AsyncImage(url: URL(string: experience.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width:UIScreen.main.bounds.width - 42,height: 154)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 8,x: 6,y: 8)
                        .padding(.horizontal,2)
                } placeholder: {
                    Image("placeholder")
                        .resizable()
                        .scaledToFill()
                        .frame(width:UIScreen.main.bounds.width - 42,height: 154)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 8,x: 6,y: 8)
                    
                        .padding(.horizontal,2)
                }

                
                
                VStack(alignment:.center) {
                    HStack () {
                        if experience.recommended {
                            RecommendedView()
                        }
                        Spacer()
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 20,height: 20)
                            .foregroundStyle(.white)
                    }
                    .padding()
                    
                    Image("360")
                        .resizable()
                        .frame(width: 37,height: 37)
                        .foregroundStyle(.white)
                    HStack () {
                        NumberOfView(numOfViews: experience.viewsCount)
                        Spacer()
                        Image("multiplepictures")
                            .resizable()
                            .frame(width: 21,height: 17.5)
                            .foregroundStyle(.white)
                    }
                    .padding()
                }
            }
            .onTapGesture {
                onSelect()
            }
            HStack {
                Text(experience.title)
                    .font(.headline)
                    .lineLimit(1)
                Spacer()
                HStack {
                    Text("\(experience.likesCount)")
                    Image(systemName: experience.isLiked ?? false ? "heart.fill":"heart")
                        .foregroundStyle(.star)
                        .frame(width: 20)
                }//.padding(.horizontal)
            }
        }
    }
}

#Preview {
    ExperienceCard(experience: Experince(id: "MOCKID1", title: "Luxor", image: "", recommended: true, likesCount: 600, viewsCount: 629, isLiked: true, location: "Cairo, Egypt", overview: "This is decription..."), onSelect: {})
}

struct RecommendedView : View {
    var body: some View {
        VStack() {
            HStack(spacing:0) {
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 9.1,height: 9.1)
                    .foregroundStyle(Color.star)
                    .padding(4)
                    
                Text("Recommended").textCase(.uppercase)
                    .font(.footnote)
                    .foregroundStyle(.white)
                    .padding(.trailing,4)
            }
            .frame(height: 18)
            .background {
                RoundedRectangle(cornerRadius: 8.75)
                    .foregroundStyle(.black.opacity(0.49))
                
                
            }
        }
    }
}

struct NumberOfView : View {
    
    @State var numOfViews:Int
    
    var body: some View {
        VStack() {
            HStack(spacing:0) {
                Image(systemName: "eye")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15,height: 10)
                    .foregroundStyle(.white)
                    .padding(4)
                    
                Text("\(numOfViews)")
                    .font(.footnote)
                    .foregroundStyle(.white)
                    .padding(.trailing,4)
            }
           
        }
    }
}
