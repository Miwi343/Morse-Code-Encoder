<<<<<<< HEAD
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

// TranslatingView.swift
struct TranslatingView: View {
    let message: String
    @Environment(\.dismiss) private var dismiss
    @StateObject private var flashlightService = FlashlightService()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
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
            flashlightService.flashMorseCode(for: message) {
                // Transmission complete
            }
        }
    }
}

// MorseViewModel.swift
class MorseViewModel: ObservableObject {
    @Published var message: String = ""
}

// MorseCode.swift
struct MorseCode {
    static let morseAlphabet: [Character: String] = [
        "A": ".-", "B": "-...", "C": "-.-.", "D": "-..", "E": ".",
        "F": "..-.", "G": "--.", "H": "....", "I": "..", "J": ".---",
        "K": "-.-", "L": ".-..", "M": "--", "N": "-.", "O": "---",
        "P": ".--.", "Q": "--.-", "R": ".-.", "S": "...", "T": "-",
        "U": "..-", "V": "...-", "W": ".--", "X": "-..-", "Y": "-.--",
        "Z": "--..", "0": "-----", "1": ".----", "2": "..---",
        "3": "...--", "4": "....-", "5": ".....", "6": "-....",
        "7": "--...", "8": "---..", "9": "----.", " ": " "
    ]
    
    static func encode(_ message: String) -> String {
        return message.uppercased().map { char in
            morseAlphabet[char] ?? ""
        }.joined(separator: " ")
    }
}

// FlashlightService.swift
import AVFoundation

class FlashlightService: ObservableObject {
    private let device = AVCaptureDevice.default(for: .video)
    
    func toggleTorch(on: Bool) {
        guard let device = device, device.hasTorch else { return }
        
        try? device.lockForConfiguration()
        device.torchMode = on ? .on : .off
        device.unlockForConfiguration()
    }
    
    func flashMorseCode(for message: String, completion: @escaping () -> Void) {
        let morse = MorseCode.encode(message)
        var delay: TimeInterval = 0
        
        for character in morse {
            switch character {
            case ".":
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.toggleTorch(on: true)
                }
                delay += 0.2
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.toggleTorch(on: false)
                }
                delay += 0.2
            case "-":
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.toggleTorch(on: true)
                }
                delay += 0.6
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.toggleTorch(on: false)
                }
                delay += 0.2
            case " ":
                delay += 0.6  // Space between letters (3 seconds)
            default:
                delay += 1.4  // Space between words (7 seconds)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            completion()
        }
    }
=======
//
//  ContentView.swift
//  Morse Code Encoder
//
//  Created by Mihir Kulshreshtha on 1/26/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
>>>>>>> ContentViewUpdate
}
