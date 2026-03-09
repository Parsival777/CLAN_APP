import SwiftUI

struct MainMenuView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 300), spacing: 25)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemTeal).opacity(0.15).edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: sizeClass == .regular ? 60 : 40) {
                        
                        VStack {
                            Text("C.L.A.N.")
                                .font(.system(size: sizeClass == .regular ? 80 : 60, weight: .black, design: .rounded))
                                .foregroundColor(.indigo)
                                .shadow(color: .indigo.opacity(0.3), radius: 5, x: 0, y: 5)
                            
                            Text("¡Aprender es Divertido!")
                                .font(.system(size: sizeClass == .regular ? 34 : 24, weight: .bold, design: .rounded))
                                .foregroundColor(.gray)
                        }
                        .padding(.top, sizeClass == .regular ? 60 : 40)
                        
                        LazyVGrid(columns: columns, spacing: 25) {
                            MenuButton(title: "Colores", color: .red, destination: AnyView(ColorsGameView()), icon: "paintpalette.fill")
                            MenuButton(title: "Números", color: .blue, destination: AnyView(NumbersGameView()), icon: "123.rectangle.fill")
                            MenuButton(title: "Letras", color: .orange, destination: AnyView(LettersGameView()), icon: "abc")
                            MenuButton(title: "Formas", color: .purple, destination: AnyView(ShapesGameView()), icon: "square.on.circle.fill")
                        }
                        .padding(.horizontal, 30)
                        
                        Spacer(minLength: 50)
                    }
                }
            }
        }
    }
}

struct MenuButton: View {
    let title: String
    let color: Color
    let destination: AnyView
    let icon: String
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.system(size: 60))
                Text(title)
                    .font(.system(size: 26, weight: .bold, design: .rounded))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, minHeight: 180)
            .background(color)
            .cornerRadius(30)
            .shadow(color: color.opacity(0.4), radius: 8, x: 0, y: 6)
        }
    }
}
