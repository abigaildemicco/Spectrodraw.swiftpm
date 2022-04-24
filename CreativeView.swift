
//It allows you to draw while looking at the spectrogram and listening to music

import SwiftUI
import AVKit

struct CreativeView: View {
    @State var songPath: String?
    @State var audio: AVAudioPlayer!
    @State var micGranted: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            if self.micGranted {
                SpectrogramView()
            }
            DrawView()
        }
        .onAppear{
            if self.songPath != nil {
                
                let songUrl = URL(fileURLWithPath: self.songPath!)
                self.audio = nil
                self.audio = try! AVAudioPlayer(contentsOf: songUrl) //adds the music track
                self.audio.numberOfLoops = -1
                self.audio?.play()
            }
        }
    }
}
