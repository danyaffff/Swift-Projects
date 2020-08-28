//
//  ContentView.swift
//  Audio player interface
//
//  Created by Даниил Храповицкий on 28.08.2020.
//

import SwiftUI
import AVKit

let url = Bundle.main.path(forResource: "audio", ofType: "mp3")

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationBarHidden(true)
                .preferredColorScheme(.dark)
        }
    }
}

struct Home: View {
    @State var audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
    @State var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State var animatedValue: CGFloat = 55
    @State var maxWidth = UIScreen.main.bounds.width / 2.2
    @State var time: Float = 0
    @State var isFavorite = false
    @State var isBookmarked = false
    
    @StateObject var album = albumData()
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(album.title)
                        .fontWeight(.semibold)
                    
                    HStack(spacing: 10) {
                        Text(album.artist)
                            .font(.caption)
                        
                        Text(album.type)
                            .font(.caption)
                    }
                }
                
                Spacer(minLength: 0)
                
                Button(action: {
                    isFavorite.toggle()
                    
                    print(isFavorite ? "Favorite" : "Not favorite")
                }, label: {
                    Image(systemName: isFavorite ? "suit.heart.fill" : "suit.heart")
                        .foregroundColor(.red)
                        .frame(width: 45, height: 45)
                        .background(Color.white)
                        .clipShape(Circle())
                })
                
                Button(action: {
                    isBookmarked.toggle()
                    
                    print(isBookmarked ? "Bookmarked" : "Not bookmarked")
                }, label: {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundColor(.black)
                        .frame(width: 45, height: 45)
                        .background(Color.white)
                        .clipShape(Circle())
                })
                .padding(.leading, 10 )
            }
            .padding()
            
            Spacer(minLength: 0)
            
            if album.artwork.count != 0 {
                Image(uiImage: UIImage(data: album.artwork)!)
                    .resizable()
                    .frame(width: 250, height: 250)
                    .cornerRadius(15)
            }
            
            ZStack {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.05))
                    
                    Circle()
                        .fill(Color.white.opacity(0.08))
                        .frame(width: animatedValue / 2, height: animatedValue / 2)
                }
                .frame(width: animatedValue, height: animatedValue)
                
                Button(action: play,
                       label: {
                        Image(systemName: album.isPlaying ? "pause.fill" : "play.fill")
                            .foregroundColor(.black)
                            .frame(width: 55, height: 55)
                            .background(Color.white)
                            .clipShape(Circle())
                })
            }
            .frame(width: maxWidth, height: maxWidth)
            .padding(.top, 30)
            
            Slider(value: Binding(get: { time }, set: { (newValue) in
                time = newValue
                
                audioPlayer.currentTime = Double(time) * audioPlayer.duration
            }))
            .padding()
            
            Text("\(Int(time * Float(audioPlayer.duration) / 60)):\((Int(time * Float(audioPlayer.duration)) % 60) < 10 ? "0" : "")\(Int(time * Float(audioPlayer.duration)) % 60)")
                .font(.caption)
            
            Spacer(minLength: 0)
        }
        .onReceive(timer, perform: { _ in
            if audioPlayer.isPlaying {
                audioPlayer.updateMeters()
                
                album.isPlaying = true
                
                time = Float(audioPlayer.currentTime / audioPlayer.duration)
                
                startAnimation()
            } else {
                album.isPlaying = false
            }
        })
        .onAppear(perform: getAudioData)
    }
    
    func play() {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        } else {
            audioPlayer.play()
        }
    }
    
    func getAudioData() {
        audioPlayer.isMeteringEnabled = true
        
        let asset = AVAsset(url: audioPlayer.url!)
        
        asset.metadata.forEach { (meta) in
            switch (meta.commonKey?.rawValue) {
            case "artwork": album.artwork = meta.value == nil ? UIImage(systemName: "photo.fill")!.pngData()! : meta.value as! Data
                
            case "artist": album.artist = meta.value == nil ? "" : meta.value as! String
                
            case "type": album.type = meta.value == nil ? "" : meta.value as! String
                
            case "title": album.title = meta.value == nil ? "" : meta.value as! String
                
            default: ()
            }
        }
    }
    
    func startAnimation() {
        var power: Float = 0
        
        for i in 0 ..< audioPlayer.numberOfChannels {
            power += audioPlayer.averagePower(forChannel: i)
        }
        
        let value = max(0, power + 55)
        
        let animated = CGFloat(value) * (maxWidth / 55)
        
        withAnimation(Animation.linear) {
            self.animatedValue = animated + 55
        }
    }
}

class albumData: ObservableObject {
    @Published var isPlaying = false
    @Published var title = ""
    @Published var artist = ""
    @Published var artwork = Data(count: 0)
    @Published var type = ""
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
