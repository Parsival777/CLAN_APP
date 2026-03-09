import SwiftUI

struct LettersGameView: View {
    let alphabet = Array("AEIOU")
    @State private var targetLetter: Character = "A"
    @State private var options: [Character] = []
    @State private var showSuccess = false
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Encuentra la letra:")
                .font(.system(size: 36, weight: .bold, design: .rounded))
            
            Text(String(targetLetter))
                .font(.system(size: 120, weight: .heavy, design: .rounded))
                .foregroundColor(.orange)
            
            HStack(spacing: 25) {
                ForEach(options, id: \.self) { letter in
                    Button(action: { checkAnswer(selected: letter) }) {
                        Text(String(letter))
                            .font(.system(size: 60, weight: .bold, design: .rounded))
                            .frame(width: 110, height: 110)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(25)
                            .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
                    }
                    .disabled(showSuccess)
                }
            }
            
            if showSuccess {
                SuccessMessageView()
            }
        }
        .background(Color.orange.opacity(0.05).edgesIgnoringSafeArea(.all))
        .onAppear(perform: setupGame)
    }
    
    func setupGame() {
        var randomLetters = alphabet.shuffled()
        targetLetter = randomLetters.removeFirst()
        options = [targetLetter, randomLetters[0], randomLetters[1]].shuffled()
        AppManager.shared.speak("Encuentra la letra \(targetLetter)")
        showSuccess = false
    }
    
    func checkAnswer(selected: Character) {
        if selected == targetLetter {
            showSuccess = true
            AppManager.shared.successVibration()
            AppManager.shared.speak("¡Fantástico!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { setupGame() }
        } else {
            AppManager.shared.errorVibration()
        }
    }
}
