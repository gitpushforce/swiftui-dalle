//
//  ImageModel.swift
//  DalleImageSwiftui
//
//  Created by masaki on 2023/02/04.
//

import Foundation

struct ImageModel: Codable {
    
    struct ImageResponse: Codable {
        let url: URL
    }
    
    let created: Int
    let data: [ImageResponse]
}
