import SwiftUI

struct ShapesGameView: View {
    let shapes = ["Círculo", "Cuadrado", "Cápsula"]
    @State private var targetShape = "Círculo"
    @State private var options: [String] = []
    @State private var showSuccess = false
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Toca el \(targetShape)")
                .font(.system(size: 36, weight: .bold, design: .rounded))
            
            VStack(spacing: 30) {
                ForEach(options, id: \.self) { shape in
                    Button(action: { checkAnswer(selected: shape) }) {
                        ShapeRenderer(shapeName: shape)
                            .frame(width: 150, height: 120)
                            .shadow(radius: 5)
                    }
                    .disabled(showSuccess)
                }
            }
            .padding()
            
            if showSuccess {
                SuccessMessageView()
            }
        }
        .onAppear(perform: setupGame)
    }
    
    func setupGame() {
        options = shapes.shuffled()
        targetShape = options.randomElement()!
        AppManager.shared.speak("Toca el \(targetShape)")
        showSuccess = false
    }
    
    func checkAnswer(selected: String) {
        if selected == targetShape {
            showSuccess = true
            AppManager.shared.successVibration()
            AppManager.shared.speak("¡Lo lograste!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { setupGame() }
        } else {
            AppManager.shared.errorVibration()
        }
    }
}

struct ShapeRenderer: View {
    let shapeName: String
    var body: some View {
        Group {
            if shapeName == "Círculo" {
                Circle().fill(Color.purple)
            } else if shapeName == "Cuadrado" {
                Rectangle().fill(Color.green)
            } else {
                Capsule().fill(Color.pink)
            }
        }
    }
}
