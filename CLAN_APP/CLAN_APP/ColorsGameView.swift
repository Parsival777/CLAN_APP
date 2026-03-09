import SwiftUI

struct ColorsGameView: View {
    let allColors: [(Color, String)] = [(.red, "Rojo"), (.blue, "Azul"), (.yellow, "Amarillo"), (.green, "Verde"), (.orange, "Naranja"), (.purple, "Morado")]
    
    @State private var targetColor: (Color, String) = (.red, "Rojo")
    @State private var currentOptions: [(Color, String)] = []
    @State private var showSuccess = false
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Toca el color:")
                .font(.system(size: 36, weight: .bold, design: .rounded))
            
            Text(targetColor.1)
                .font(.system(size: 60, weight: .heavy, design: .rounded))
                .foregroundColor(targetColor.0)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 30) {
                ForEach(currentOptions, id: \.1) { colorOption in
                    Button(action: { checkAnswer(selected: colorOption) }) {
                        Circle()
                            .fill(colorOption.0)
                            .frame(height: 140)
                            .shadow(radius: 5)
                    }
                    .disabled(showSuccess)
                }
            }
            .padding(30)
            
            if showSuccess {
                SuccessMessageView()
            } else {
                Spacer().frame(height: 60)
            }
        }
        .onAppear(perform: setupGame)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func setupGame() {
        currentOptions = Array(allColors.shuffled().prefix(4))
        targetColor = currentOptions.randomElement()!
        AppManager.shared.speak("Toca el color \(targetColor.1)")
        showSuccess = false
    }
    
    func checkAnswer(selected: (Color, String)) {
        if selected.1 == targetColor.1 {
            showSuccess = true
            AppManager.shared.successVibration()
            AppManager.shared.speak("¡Muy bien!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { setupGame() }
        } else {
            AppManager.shared.errorVibration()
        }
    }
}
