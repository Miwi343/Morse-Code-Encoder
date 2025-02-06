// ContentView.swift
import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject private var morseViewModel = MorseViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack {
                    Text("MORSE HELPER")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 50)
                    
                    TextField("Enter message here", text: $morseViewModel.message)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Spacer()
                    
                    NavigationLink(destination: TranslatingView(message: morseViewModel.message)) {
                        Text("TRANSLATE -->")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding()
                }
            }
        }
    }
}



// MorseViewModel.swift
class MorseViewModel: ObservableObject {
    @Published var message: String = ""
}


#Preview {
    ContentView()
}
