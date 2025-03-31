import SwiftUI

struct JSONBeautifierFeature {
    @Binding var inputText: String
    @Binding var showingJSONWindow: Bool
    @Binding var formattedJSON: String

    func isValidJSON(_ string: String) -> Bool {
        print("Validating JSON string: \(string)")
        guard let data = string.data(using: .utf8) else { return false }
        do {
            _ = try JSONSerialization.jsonObject(with: data)
            return true
        } catch {
            return false
        }
    }

    func formatJSON(_ string: String) -> String {
        print("Formatting JSON string: \(string)")
        guard let data = string.data(using: .utf8) else { return string }
        do {
            let json = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(
                withJSONObject: json, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8) ?? string
        } catch {
            return string
        }
    }

    var jsonWindowView: some View {
        VStack {
            Text("Formatted JSON")
                .font(.headline)
                .padding()

            TextEditor(text: .constant(formattedJSON))
                .font(.monospaced(.body)())
                .padding()

            Button("Close") {
                showingJSONWindow = false
            }
            .padding()
        }
        .frame(width: 600, height: 400)
    }
}
