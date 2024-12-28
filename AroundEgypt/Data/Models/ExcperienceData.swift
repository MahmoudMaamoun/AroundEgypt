//
//  Welcome.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 28/12/2024.
//


import Foundation
// MARK: - Welcome
struct ExcperienceResponse: Codable {
    let meta: Meta
    let data: [ExcperinceData]
    let pagination: Pagination
}
// MARK: - Datum
struct ExcperinceData: Codable {
    let id, title: String
    let coverPhoto: String
    let description: String
    let viewsNo, likesNo, recommended, hasVideo: Int
    let tags: [City]
    let city: City
    let tourHTML: String
    let famousFigure: String
    let period, era: Era?
    let founded, detailedDescription, address: String
    let gmapLocation: GmapLocation
    let openingHours: OpeningHours
    let translatedOpeningHours: TranslatedOpeningHours
    let startingPrice: Int?
    let ticketPrices: [TicketPrice]
    let experienceTips: [String]
    let isLiked: Bool?
    let reviews: [Review]
    let rating, reviewsNo: Int
    let audioURL: String
    let hasAudio: Bool
    enum CodingKeys: String, CodingKey {
        case id, title
        case coverPhoto = "cover_photo"
        case description
        case viewsNo = "views_no"
        case likesNo = "likes_no"
        case recommended
        case hasVideo = "has_video"
        case tags, city
        case tourHTML = "tour_html"
        case famousFigure = "famous_figure"
        case period, era, founded
        case detailedDescription = "detailed_description"
        case address
        case gmapLocation = "gmap_location"
        case openingHours = "opening_hours"
        case translatedOpeningHours = "translated_opening_hours"
        case startingPrice = "starting_price"
        case ticketPrices = "ticket_prices"
        case experienceTips = "experience_tips"
        case isLiked = "is_liked"
        case reviews, rating
        case reviewsNo = "reviews_no"
        case audioURL = "audio_url"
        case hasAudio = "has_audio"
    }
}
// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let disable: String?
    let topPick: Int
    enum CodingKeys: String, CodingKey {
        case id, name, disable
        case topPick = "top_pick"
    }
}
// MARK: - Era
struct Era: Codable {
    let id, value, createdAt, updatedAt: String
    enum CodingKeys: String, CodingKey {
        case id, value
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
// MARK: - GmapLocation
struct GmapLocation: Codable {
    let type: String
    let coordinates: [Double]
}
// MARK: - OpeningHours
struct OpeningHours: Codable {
    let sunday, monday, tuesday, wednesday: [String]?
    let thursday, friday, saturday: [String]?
}

// MARK: - Review
struct Review: Codable {
    let id, experience, name: String
    let rating: Int
    let comment, createdAt: String
    enum CodingKeys: String, CodingKey {
        case id, experience, name, rating, comment
        case createdAt = "created_at"
    }
}
// MARK: - TicketPrice
struct TicketPrice: Codable {
    let type: String
    let price: Int
}
// MARK: - TranslatedOpeningHours
struct TranslatedOpeningHours: Codable {
    let sunday, monday, tuesday, wednesday: Day?
    let thursday, friday, saturday: Day?
}
// MARK: - Day
struct Day: Codable {
    let day: String
    let time: String
}
// MARK: - Meta
struct Meta: Codable {
    let code: Int
    let errors: [String]
}
// MARK: - Pagination
struct Pagination: Codable {
   
}
