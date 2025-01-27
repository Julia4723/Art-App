//
//  ArtModel.swift
//  Art App
//
//  Created by user on 27.01.2025.
//

import UIKit

struct ArtModel: Codable {
    let artists: [Artist]
}

struct Artist: Codable {
    let name, bio, image: String
    let works: [Work]
}

struct Work: Codable {
    let title, image, info: String
}


