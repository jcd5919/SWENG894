//
//  GoogleSearchData.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 10/1/24.
//

import Foundation

struct GoogleSearchData: Codable {
    
    let items: [Items]
    
    struct Items: Codable{
        let title: String?
        let snippet: String?
        let link: String?
        
        let pagemap: PageMap
        
        struct PageMap: Codable{
            
            let metatags: [Metatag]
            
            struct Metatag: Codable{
                
                let ogImage: String?
                enum CodingKeys: String, CodingKey{
                    case ogImage = "og:Image"
                }
            }
        }
    }
    
}
