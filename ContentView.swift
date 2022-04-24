
import SwiftUI
import AVFoundation

struct ContentView: View {
    @State var pageIndex: Int = 1
    @State var pickedSongPath: String?
    @State var micGranted: Bool = false
    
    var body: some View {
        VStack {
            switch pageIndex {
            case 1:
                IntroView(index: $pageIndex)
            case 2:
                BubbleView(index: $pageIndex, songPath: $pickedSongPath)
            case 3:
                CreativeView(songPath: pickedSongPath, micGranted: micGranted)
            default:
                EmptyView()
            }
        }
        .onAppear { //microphone access request on startup
            switch AVCaptureDevice.authorizationStatus(for: .audio) {
            case .authorized:
                self.micGranted = true
                break
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .audio,
                                              completionHandler: { granted in
                    if granted {
                        self.micGranted = true
                    }
                })
                break
            default:
                break
            }
        }
    }
}
