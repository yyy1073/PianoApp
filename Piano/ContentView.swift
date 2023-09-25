//
//  ContentView.swift
//  Piano
//
//  Created by Henry Yun on 9/7/23.
//

import SwiftUI
import AVKit


//var whiteKeyArray = ["key01", "key03", "key05", "key06", "key08", "key10", "key12", "key13", "key15", "key17"]
//var blackKeyArray = ["key02", "key04", "key07", "key09", "key11", "key14","key16"]

enum PianoNote: String {
    //enumKay = rawValue
    case C = "key01"
    case D = "key03"
    case E = "key05"
    case F = "key06"
    case G = "key08"
    case A = "key10"
    case B = "key12"
    case C2 = "key13"
    case D2 = "key15"
    case E2 = "key17"
}

class SoundManager {
    static let instance = SoundManager() // To avoid initializing sound manager for each view.
    
    var player: AVAudioPlayer?
    
    func playKey(keyIdentifier: String) {
        guard let url = Bundle.main.url(forResource: keyIdentifier, withExtension: ".mp3"),
              let myPlayer = try? AVAudioPlayer(contentsOf: url)
        else { return }
        player = myPlayer

        if let player = player {
            player.play()
        }
    }
}

struct ContentView: View {
    func createWhiteKey(keyIdentifier: String) -> some View { // https://stackoverflow.com/questions/65131862/error-value-of-type-some-view-has-no-member-stroke
        
        // Avoid AnyView? https://www.swiftbysundell.com/articles/avoiding-anyview-in-swiftui/ *****
        
        // Here, Rectangle() can't .fill() and .stroke at the same time. https://forums.swift.org/t/beginner-question-about-circles-swiftui/34210/3
        
        return Button {
            SoundManager.instance.playKey(keyIdentifier: keyIdentifier)
        } label: {
            ZStack{
                Rectangle()
                    .fill(.white)
                    .frame(width: 60, height: 300)
                Rectangle()
                    .stroke(Color.black, lineWidth: 5)
                    .frame(width: 60, height: 300)
            }
        }
    }
    
    func playNote(note: PianoNote) {
        print(note.rawValue)
    }
    
    func whoa() {
        playNote(note: .D)
    }
    
    func createBlackKey(keyIdentifier: String) -> some View {
        return Button {
            SoundManager.instance.playKey(keyIdentifier: keyIdentifier)
        } label: {
            Rectangle()
                .fill(.black)
                .frame(width: 50, height: 150)
        }
    }

    var soundManager = SoundManager()
//    var whiteKeyArray = ["key01", "key03", "key05", "key06", "key08", "key10", "key12", "key13", "key15", "key17"]
    var blackKeyArray = ["key02", "key04", "key07", "key09", "key11", "key14","key16"]
    
    var whiteKeyNotes: [PianoNote] = [.C, .D, .E, .F, .G, .A, .B, .C2, .D2, .E2]
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        ZStack { // Background view
            ZStack {
                Color.gray.ignoresSafeArea()
                Rectangle()
                    .stroke(.black, lineWidth:5)
                    //.fill(.blue) // **Why doesn't this work? Is it a bug?
                    .frame(width: 600, height: 300)
                    .position(x: screenWidth / 2, y: screenHeight / 2)
                
                // White keys
                HStack(alignment: .center, spacing: 0) {
                    ForEach(0..<whiteKeyNotes.count) { number in
                        createWhiteKey(keyIdentifier: whiteKeyNotes[number].rawValue)
                    }
                }
                .position(x: screenWidth / 2, y: screenHeight / 2)
                
                // Black keys
                HStack(alignment: .center, spacing: 11) {
                    ForEach(0..<2) { number in
                        createBlackKey(keyIdentifier: blackKeyArray[number])
                    }
                }
                .position(x: screenWidth / 3.95, y: screenHeight / 2 - 75)
                
                HStack(alignment: .center, spacing: 11) {
                    ForEach(2..<5) { number in
                        createBlackKey(keyIdentifier: blackKeyArray[number])
                    }
                }
                .position(x: screenWidth / 2, y: screenHeight / 2 - 75)
                
                HStack(alignment: .center, spacing: 11) {
                    ForEach(5..<7) { number in
                        createBlackKey(keyIdentifier: blackKeyArray[number])
                    }
                }
                .position(x: screenWidth / 1.34, y: screenHeight / 2 - 75)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
