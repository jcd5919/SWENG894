//
//  SearchPage.swift
//  PictureYourFood
//
//  Created by Joseph Duckwall on 9/16/24.
//

import SwiftUI

struct ContentView: View {
    @State private var ingredient1: String = ""
    @State private var ingredient2: String = ""
    var body: some View {
        
        VStack{
            
            Text("Picture Your Food!")
                .font(Font.title)
                .padding()
            Spacer()
            
            VStack {
                TextField(
                    "Ingredient #1",
                    text: $ingredient1
                )
                TextField(
                    "Ingredient #2",
                    text: $ingredient2
                )
                .disableAutocorrection(true)
            }
            .textFieldStyle(.roundedBorder)
            .fixedSize()
            Spacer()
        }
    }
}

func getIngredients(ingredient1: String, ingredient2: String) -> String {
    let fullList = ingredient1 + " " + ingredient2
    return fullList
}
#Preview {
    SearchPage()
}
