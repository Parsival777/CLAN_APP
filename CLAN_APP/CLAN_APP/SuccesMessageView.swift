import SwiftUI

struct SuccessMessageView: View {
    @State private var animate = false
    
    var body: some View {
        HStack {
            Image(systemName: "star.fill").foregroundColor(.yellow)
            Text("¡Excelente!")
                .font(.system(size: 45, weight: .heavy, design: .rounded))
                .foregroundColor(.green)
            Image(systemName: "star.fill").foregroundColor(.yellow)
        }
        .scaleEffect(animate ? 1.1 : 0.5)
        .opacity(animate ? 1 : 0)
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                animate = true
            }
        }
    }
}

