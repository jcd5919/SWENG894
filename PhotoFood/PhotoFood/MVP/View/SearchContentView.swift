//
//  SearchContentView.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 10/14/24.
//

import SwiftUI



struct SearchContentView: View {
    

    
    @State private var fetch = SearchManager()
    @State var searchWord = ""

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20){
                ForEach(0..<10) { index in
                    GoogleSearchView(index:index)
                        .padding()
                }
                .padding()
            }
            Divider()
                .onAppear{
                    fetch.fetchGoogle(searchWord: searchWord)
                }
        }
        
        
    }
}

#Preview {
    SearchContentView()
}
