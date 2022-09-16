//
//  ContentView.swift
//  Mnemo
//
//  Created by Ana on 11/9/22.
//

import SwiftUI
import CoreData
import AVKit

private let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "MNEMO", ofType: "mp4")!))

struct PlayerView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVideoPlayer {
        return UIVideoPlayer()
    }
    func updateUIView(_ uiView: UIVideoPlayer, context: Context) {
        
    }
}


struct ContentView: View {
    @State var TimeRemaining = 4
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var image: Image?
    @EnvironmentObject var appState: AppState
    @State private var showingHomeView = false
    @State private var isPresented = false
    
    var body: some View {
        ZStack {
            PlayerView()
                .onAppear() {
                    player.play()
                }
            
                .onDisappear() {
                    player.pause()
                }
            
                .edgesIgnoringSafeArea(.all)
                .onReceive(timer) { time in
                    if TimeRemaining > 0 {
                        TimeRemaining -= 1
                        if TimeRemaining == 0 {
                            showingHomeView.toggle()
                            timer.upstream.connect().cancel()
                    }
                        }
                        }
        }
        
.sheet(isPresented: $showingHomeView) {
    HomeViewClass.HomeView()
                    }
            }
            }
        


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
            .previewLayout(.sizeThatFits)

    }
}
