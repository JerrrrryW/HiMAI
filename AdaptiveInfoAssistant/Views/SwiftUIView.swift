import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Primary background style
            Text("Primary Background")
                .padding()

            // Secondary background style
            Text("Secondary Background")
                .foregroundColor(.secondary)
                .padding()

            // Tertiary background style
            Text("Tertiary Background")
                .foregroundStyle(.tertiary)
                .backgroundStyle(.tertiary)
                .padding()
                .background(.ultraThickMaterial)
                .cornerRadius(20)

            // Quaternary background style
            Text("Quaternary Background")
                .foregroundStyle(.quaternary)
                .backgroundStyle(.quaternary)
                .padding()
        }
        .padding()
        .glassBackgroundEffect()
    }
}

#Preview {
    SwiftUIView()
}
