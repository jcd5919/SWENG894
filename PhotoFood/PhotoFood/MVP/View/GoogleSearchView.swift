//
//  GoogleSearchView.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 10/14/24.
//

import SwiftUI



extension String {
    
    func load() -> UIImage {
        do {
            
            guard let url = URL(string:self) else {return UIImage()}
            let data: Data = try
            Data(contentsOf: url)
            
            return UIImage(data: data) ?? UIImage()
        } catch {
            
        }
        return UIImage()
    }
}




struct GoogleSearchView: View {
    
    @ObservedObject var searchManager = SearchManager.shared()
    @State var index: Int
    
    var body: some View {

        ScrollView (.vertical){
            
            VStack(spacing: 20){
                
                ForEach(searchManager.items.allItems, id: \.id ) { item in
                    
                    VStack{
                        
                        Text(item.title[index]!)
                            .frame(width: 200, height: 60)
                            .font(.headline)
                        ForEach(searchManager.images.allImages, id: \.id) { image in
                            Image(uiImage: (image.image[index]?.load() ?? UIImage(systemName: "camera"))!)
                                .resizable()
                                .frame(width: 200, height: 200)
                        }
                        Text(item.description[index]!)
                            .frame(width: 200, height: 60)
                            .font(.system(size: 15))
                        
                        Text(item.link[index]!)
                            .frame(width: 200)
                            .font(.system(size: 15))
                            .foregroundColor(.blue)
                        Spacer()
                    }
                }
            }.frame(maxHeight: .infinity)
        }
        
    }
}

