//
//  ExperinceCard.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//

import SwiftUI

struct ExperienceCard: View {
    var body: some View {
        ZStack() {
            Image("placeholder")
                .resizable()
                .scaledToFill()
                .frame(height: 154)
                .clipped()
                .padding(.horizontal,2)
           
            VStack(alignment:.center) {
                HStack () {
                    RecommendedView()
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
                    NumberOfView(numOfViews: 32)
                    Spacer()
                    Image("multiplepictures")
                        .resizable()
                        .frame(width: 21,height: 17.5)
                        .foregroundStyle(.white)
                }
                .padding()
            }
        }
    }
}

#Preview {
    ExperienceCard()
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