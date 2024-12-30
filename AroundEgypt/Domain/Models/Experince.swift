//
//  Experince.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//

struct Experince:Identifiable,Equatable {
    
    let id:String
    let title:String
    let image:String
    let location:String
    let recommended:Bool
    var likesCount:Int
    let viewsCount:Int
    let isLiked:Bool?
    let overview:String
    
    init(id: String, title: String, image: String, recommended: Bool, likesCount: Int, viewsCount: Int, isLiked: Bool,location:String,overview:String) {
        self.id = id
        self.title = title
        self.image = image
        self.recommended = recommended
        self.likesCount = likesCount
        self.viewsCount = viewsCount
        self.isLiked = isLiked
        self.location = location
        self.overview = overview
    }
    
    init(data:ExcperinceData){
        self.id = data.id
        self.title = data.title
        self.image = data.coverPhoto
        self.recommended = data.recommended == 1 ? true:false
        self.likesCount = data.likesNo
        self.viewsCount = data.viewsNo
        self.isLiked = data.isLiked
        self.location = data.address
        self.overview = data.description
    }
    
    init(data:ExcperinceEntity){
        self.id = data.id!
        self.title = data.title!
        self.image = data.imageURL ?? ""
        self.recommended = data.recommended
        self.likesCount = Int(data.likesCount)
        self.viewsCount = Int(data.numOfViews)
        self.isLiked = data.isLiked
        self.location = data.address!
        self.overview = data.overview!
    }
    init(data:RecentExperince){
        self.id = data.id!
        self.title = data.title!
        self.image = data.imageURL ?? ""
        self.recommended = data.recommended
        self.likesCount = Int(data.likesCount)
        self.viewsCount = Int(data.numOfViews)
        self.isLiked = data.isLiked
        self.location = data.address!
        self.overview = data.overview!
    }
}
