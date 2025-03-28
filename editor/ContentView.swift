//
//  ContentView.swift
//  editor
//
//  Created by Hai Vo on 3/25/25.
//

import SwiftUI
import Inject

struct ContentView: View {
    @ObserveInjection var inject
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, worlds Test")
        }
        .padding()
        .enableInjection()
    }
}

#Preview {
    ContentView()
}
