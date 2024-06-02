//
//  AudioRecorder.swift
//  Deaf
//
//  Created by Davide Galdiero on 31/05/24.
//

import Foundation
import AVFoundation

@Observable
class AudioRecorder: NSObject{
    var isRecording = false
    var hasMicAccess = false
    var showMicAccessAlert = false
    
    var audioRecorder: AVAudioRecorder?
    
    private func requestMicrophoneAccess(){
        AVAudioApplication.requestRecordPermission { success in
            if success {
                self.hasMicAccess = true
            }
            else {
                self.showMicAccessAlert = true
            }
        }
    }
    
    func setup() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord, options: .defaultToSpeaker)
            try audioSession.setActive(true)
            
            let settings: [String : Any] = [
                AVFormatIDKey: Int(kAudioFormatLinearPCM),
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            self.audioRecorder = try AVAudioRecorder(url: FileSystemManager.getRecordingTempURL(), settings: settings)
            self.audioRecorder?.isMeteringEnabled = true
            self.audioRecorder?.delegate = self
            self.requestMicrophoneAccess()
        }
        catch {
            print("Error: \(error)")
        }
    }
    
    func record(){
        if hasMicAccess{
            self.audioRecorder?.record()
            self.isRecording = true
        }
        else {
            self.requestMicrophoneAccess()
        }
    }
    
    func stopRecording(completion: (Data?, String?) -> Void){
        self.audioRecorder?.stop()
        let audioData = FileSystemManager.saveRecordingFile()
        completion(audioData.0, audioData.1)
        
        self.isRecording = false
    }
}

extension AudioRecorder: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        self.isRecording = false
    }
}
