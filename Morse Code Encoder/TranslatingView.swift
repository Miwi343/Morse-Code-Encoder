// TranslatingView.swift
import SwiftUI

struct TranslatingView: View {
    let message: String
    @Environment(\.dismiss) private var dismiss
    @StateObject private var flashlightService = FlashlightService()
    @State private var backgroundColor: Color = .black
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            VStack {
                Text("TRANSLATING")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                Spacer()
                
                Button("<-- BACK") {
                    dismiss()
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(8)
                .padding()
            }
        }
        .onAppear {
            flashlightService.flashMorseCode(for: message, screenFlash: { isOn in
                backgroundColor = isOn ? .white : .black
            }) {
                // Transmission complete
            }
        }
    }
}
