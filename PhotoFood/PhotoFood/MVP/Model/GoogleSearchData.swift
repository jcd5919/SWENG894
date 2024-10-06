//
//  GoogleSearchData.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 10/1/24.
//

import Foundation

struct GoogleSearchData: Codable {
    
    let result: [Results]
    
    struct Results: Codable{
        let title: String?
        let short_desc: String?
        let url_link: String?
        
        let pagemap: PageMap
        
        struct PageMap: Codable{
            
            let metaTags: [MetaTag]
            
            struct MetaTag: Codable{
                
                let ogImage: String?
                enum CodingKeys: String, CodingKey{
                    case ogImage = "ogImage"
                }
            }
                    }
    }
    
}
