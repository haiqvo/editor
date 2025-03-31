import SwiftUI

struct tidbitEditor: View {
    @Binding var text: String
    @Binding var formattedJSON: String
    let jsonBeautifier: JSONBeautifierFeature
    let height: CGFloat

    @State private var lastTextChange = Date()
    @State private var isTyping = false

    private let typingDelay: TimeInterval = 3.0  // 1 second delay for typing completion

    var body: some View {
        TextEditor(text: $text)
            .font(.body)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .onChange(of: text) { oldValue, newValue in
                // Update last text change time
                lastTextChange = Date()
                isTyping = true

                // Format JSON immediately on any change
                formattedJSON = jsonBeautifier.formatJSON(newValue)

                // Check if this was a paste event by comparing lengths
                if abs(newValue.count - oldValue.count) > 1 {
                    print("Paste event detected")
                    // Handle paste event here
                }
            }
            .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
                // Check if we've stopped typing
                if isTyping && Date().timeIntervalSince(lastTextChange) >= typingDelay {
                    isTyping = false
                    print("Typing completed")
                    // Handle typing completion here
                }
            }
    }
}
