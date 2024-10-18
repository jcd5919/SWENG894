//
//  SearchManager.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 10/14/24.
//

import Foundation



class SearchManager: ObservableObject {
    
    @Published var items = ItemsData(allItems: [])
    @Published var images = ImageData(allImages: [])
    
    private static var sharedSearchManager: SearchManager = {
        let searchManager = SearchManager()
        return searchManager
    }()
    
    class func shared() -> SearchManager {
        return sharedSearchManager
    }
    
    func fetchGoogle(searchWord: String){
        let urlString = "https://customsearch.googleapis.com/customsearch/v1?key=\(Constants.API_KEY)&cx=\(Constants.API_ID)&q=\(searchWord)"
        performSearch(url: urlString)
    }
    func performSearch(url: String) {
        if let url = URL(string: url){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url){(data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(googleData: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(googleData: Data){
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let searchResponse = try decoder.decode(GoogleSearchData.self, from: googleData)
            let thumbnail = searchResponse.items.map({$0.pagemap.metatags.map({$0.ogImage})})
            let allImages = Array(thumbnail.joined())
            let title = searchResponse.items.map({$0.title})
            let description = searchResponse.items.map({$0.snippet})
            let link = searchResponse.items.map({$0.link})
            
            DispatchQueue.main.async {
                let googleResultImages = SearchImages(image: allImages)
                SearchManager.shared().images.allImages.append(googleResultImages)
            }
            let googleResult = GoogleSearchModel(title: title, description: description, link: link)
            DispatchQueue.main.async {
                SearchManager.shared().items.allItems.append(googleResult)
            }
        } catch{
            print(error)
        }
    }
}


