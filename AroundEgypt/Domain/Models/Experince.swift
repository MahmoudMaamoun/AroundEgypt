//
//  Experince.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//

struct Experince {
    
    let id:String
    let title:String
    let image:String
    let recommended:Bool
    let likesCount:Int
    let viewsCount:Int
    let isLiked:Bool?
    
    init(id: String, title: String, image: String, recommended: Bool, likesCount: Int, viewsCount: Int, isLiked: Bool) {
        self.id = id
        self.title = title
        self.image = image
        self.recommended = recommended
        self.likesCount = likesCount
        self.viewsCount = viewsCount
        self.isLiked = isLiked
    }
    
    init(data:ExcperinceData){
        self.id = data.id
        self.title = data.title
        self.image = data.coverPhoto
        self.recommended = data.recommended == 1 ? true:false
        self.likesCount = data.likesNo
        self.viewsCount = data.viewsNo
        self.isLiked = data.isLiked
    }
}
