import AVFoundation

class FlashlightService: ObservableObject {
    private let device = AVCaptureDevice.default(for: .video)
    
    func toggleTorch(on: Bool) {
        guard let device = device, device.hasTorch else { return }
        
        try? device.lockForConfiguration()
        device.torchMode = on ? .on : .off
        device.unlockForConfiguration()
    }
    
    func flashMorseCode(for message: String, screenFlash: @escaping (Bool) -> Void, completion: @escaping () -> Void) {
        let morse = MorseCode.encode(message)
        var delay: TimeInterval = 0
        
        for character in morse {
            switch character {
            case ".":
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.toggleTorch(on: true)
                    screenFlash(true)
                }
                delay += 0.2
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.toggleTorch(on: false)
                    screenFlash(false)
                }
                delay += 0.2
            case "-":
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.toggleTorch(on: true)
                    screenFlash(true)
                }
                delay += 0.6
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.toggleTorch(on: false)
                    screenFlash(false)
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
}
