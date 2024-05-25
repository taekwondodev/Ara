//
//  VideoPlayerView.swift
//  Deaf
//
//  Created by Davide Galdiero on 23/05/24.
//

import SwiftUI
import AVKit

struct VideoPlayerView: UIViewControllerRepresentable {
    @ObservedObject var viewModel: AVPlayerViewModel
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = viewModel.player
        controller.canStartPictureInPictureAutomaticallyFromInline = true
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, AVPlayerViewControllerDelegate {
        let parent: VideoPlayerView
        
        init(_ parent: VideoPlayerView) {
            self.parent = parent
        }
        
        func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
            parent.viewModel.pipStatus = .willStart
        }
        
        func playerViewControllerDidStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
            parent.viewModel.pipStatus = .didStart
        }
        
        func playerViewControllerWillStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
            parent.viewModel.pipStatus = .willStop
        }
        
        
        func playerViewControllerDidStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
            parent.viewModel.pipStatus = .didStop
        }
    }
    
}
