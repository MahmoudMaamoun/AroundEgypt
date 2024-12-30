//
//  SingleExperinceResponse.swift
//  AroundEgypt
//
//  Created by Mahmoud Maamoun on 30/12/2024.
//

struct SingleExcperienceResponse: Codable {
    let meta: Meta
    let data: ExcperinceData
}

struct ExcperinceLikeResponse: Codable {
    let meta: Meta
    let data: Int
    let pagination: Pagination
}
