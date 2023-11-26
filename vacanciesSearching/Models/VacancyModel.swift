//
//  VacancyModel.swift
//  vacanciesSearching
//
//  Created by Эдгар Исаев on 26.11.2023.
//

import Foundation

struct VacancyModel: Decodable {
    let items: [Item]
    let alternateURL: String

    enum CodingKeys: String, CodingKey {
        case items
        case alternateURL = "alternate_url"
    }
}

struct Item: Decodable {
    let name: String
    let salary: Salary
    let employer: Employer
    let snippet: Snippet

    enum CodingKeys: String, CodingKey {
        case name
        case salary
        case employer
        case snippet
    }
}

struct Salary: Decodable {
    let from, to: Int?
    let currency: Currency
    let gross: Bool
}

enum Currency: String, Codable {
    case byr = "BYR"
    case kzt = "KZT"
    case rur = "RUR"
    case uzs = "UZS"
}

struct Employer: Decodable {
    let name: String
    let logoUrls: LogoUrls?

    enum CodingKeys: String, CodingKey {
        case name
        case logoUrls = "logo_urls"
    }
}

struct LogoUrls: Decodable {
    let the90, the240: String
    let original: String

    enum CodingKeys: String, CodingKey {
        case the90 = "90"
        case the240 = "240"
        case original
    }
}

struct Snippet: Decodable {
    let requirement, responsibility: String?
}
