//
//  ContentView.swift
//  editor
//
//  Created by Hai Vo on 3/25/25.
//

import Inject
import SwiftUI

struct ContentView: View {
    @ObserveInjection var inject
    @State private var selectedItem: String? = nil
    @State private var inputText: String = ""
    @State private var showingJSONWindow = false
    @State private var formattedJSON: String = ""

    private var jsonBeautifier: JSONBeautifierFeature {
        JSONBeautifierFeature(
            inputText: $inputText,
            showingJSONWindow: $showingJSONWindow,
            formattedJSON: $formattedJSON
        )
    }

    var body: some View {
        NavigationSplitView {
            // Sidebar content
            List(["Item 1", "Item 2", "Item 3"], id: \.self) { item in
                Text(item)
            }
            .navigationTitle("Sidebar")
        } detail: {
            // Main content
            GeometryReader { geometry in
                VStack {
                    tidbitEditor(
                        text: $inputText,
                        formattedJSON: $formattedJSON,
                        jsonBeautifier: jsonBeautifier,
                        height: geometry.size.height / 2
                    )

                    if jsonBeautifier.isValidJSON(inputText) {
                        Button("Beautify JSON") {
                            showingJSONWindow = true
                        }
                        .padding(.vertical)
                    }

                    Spacer()

                    Button("Save") {
                        print("Save button pressed - testing console output")
                    }
                    .padding(.bottom)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .sheet(isPresented: $showingJSONWindow) {
            jsonBeautifier.jsonWindowView
        }
        .enableInjection()
    }
}

#Preview {
    ContentView()
}
