//
//  JSONModels.swift
//  SearchImage
//
//  Created by Limi Das on 12/09/22.
//  Copyright © 2022 Limi Das. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
//    let type, didUMean: String?
//    let totalCount: Int?
//    let relatedSearch: [JSONAny]
    let value: [Value]?

    enum CodingKeys: String, CodingKey {
        //case type = "_type"
        //case didUMean, totalCount, value
        case value
    }
}

// MARK: - Value
struct Value: Codable {
    let id, title: String?
    let url: String?
    let valueDescription, body, snippet, keywords: String?
    let language: String?
    let isSafe: Bool?
    let datePublished: String?
    let provider: Provider?
    let image: Image?

    enum CodingKeys: String, CodingKey {
        case id, title, url
        case valueDescription = "description"
        case body, snippet, keywords, language, isSafe, datePublished, provider, image
    }
}

// MARK: - Image
struct Image: Codable {
    let url: String?
    let height, width: Int?
    let thumbnail: String?
    let thumbnailHeight, thumbnailWidth: Int?
    let base64Encoding: String?
    let name, title: String?
    let provider: Provider?
    let imageWebSearchURL: String?
    let webpageURL: String?

    enum CodingKeys: String, CodingKey {
        case url, height, width, thumbnail, thumbnailHeight, thumbnailWidth, base64Encoding, name, title, provider
        case imageWebSearchURL = "imageWebSearchUrl"
        case webpageURL = "webpageUrl"
    }
}

// MARK: - Provider
struct Provider: Codable {
    let name, favIcon, favIconBase64Encoding: String?
}

