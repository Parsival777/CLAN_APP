import SwiftUI

struct NumbersGameView: View {
    @State private var targetNumber = 1
    @State private var options: [Int] = []
    @State private var showSuccess = false
    
    var body: some View {
        VStack(spacing: 40) {
            Text("¿Cuántas manzanas hay?")
                .font(.system(size: 32, weight: .bold, design: .rounded))
            
            WrapView(count: targetNumber)
                .frame(height: 150)
                .padding()
            
            HStack(spacing: 20) {
                ForEach(options, id: \.self) { number in
                    Button(action: { checkAnswer(selected: number) }) {
                        Text("\(number)")
                            .font(.system(size: 50, weight: .heavy, design: .rounded))
                            .frame(width: 90, height: 90)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .shadow(radius: 5)
                    }
                    .disabled(showSuccess)
                }
            }
            
            if showSuccess {
                SuccessMessageView()
            }
        }
        .onAppear(perform: setupGame)
    }
    
    func setupGame() {
        targetNumber = Int.random(in: 1...5)
        var newOptions = Set([targetNumber])
        while newOptions.count < 3 { newOptions.insert(Int.random(in: 1...6)) }
        options = Array(newOptions).shuffled()
        AppManager.shared.speak("¿Cuántas manzanas hay?")
        showSuccess = false
    }
    
    func checkAnswer(selected: Int) {
        if selected == targetNumber {
            showSuccess = true
            AppManager.shared.successVibration()
            AppManager.shared.speak("¡Excelente!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { setupGame() }
        } else {
            AppManager.shared.errorVibration()
        }
    }
}

struct WrapView: View {
    let count: Int
    var body: some View {
        HStack(spacing: 15) {
            ForEach(0..<count, id: \.self) { _ in
                Image(systemName: "applelogo")
                    .foregroundColor(.red)
                    .font(.system(size: 60))
            }
        }
    }
}
