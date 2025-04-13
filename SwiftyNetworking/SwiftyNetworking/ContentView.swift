//
//  ContentView.swift
//  SwiftyNetworking
//
//  Created by angel zambrano on 4/12/25.
//

import SwiftUI

struct ContentView: View {
    private let apiService = APIService.shared
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
