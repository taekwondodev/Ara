//
//  AVPlayerViewModel.swift
//  Deaf
//
//  Created by Davide Galdiero on 23/05/24.
//

//import Foundation
//import AVFoundation
//import Combine
//
//final class AVPlayerViewModel: ObservableObject {
//
//    @Published var pipStatus: PipStatus?
//    @Published var media: Media?                   //media è quello che riproduce
//
//    let player = AVPlayer()
//    private var cancellable: AnyCancellable?
//    
//    init() {
//        setAudioSessionCategory(to: .playback)
//        cancellable = $media
//            .compactMap({ $0 })
//            .compactMap({ /*URL(string: $0.url)*/ $0.url })
//            .sink(receiveValue: { [weak self] in
//                guard let self = self else { return }
//                self.player.replaceCurrentItem(with: AVPlayerItem(url: $0))
//            })
//    }
//    
//    func play() {
//        player.play()
//    }
//    
//    func pause() {
//        player.pause()
//    }
//    
//    func setAudioSessionCategory(to value: AVAudioSession.Category) {
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//           try audioSession.setCategory(value)
//        } catch {
//           print("Setting category to AVAudioSessionCategoryPlayback failed.")
//        }
//    }
//}
//
//struct Media {
//    let url: URL
//}
//
//enum PipStatus {
//    case willStart
//    case didStart
//    case willStop
//    case didStop
//}
