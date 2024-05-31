//
//  SpeechRecognizer.swift
//  Deaf
//
//  Created by Davide Galdiero on 17/05/24.
//

import AVFoundation
import Speech
import Foundation
import SwiftUI

class SpeechRecognizer: NSObject, ObservableObject, SFSpeechRecognizerDelegate {
    @Published var transcript: String = ""
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private var recognizer: SFSpeechRecognizer?
    
    @Published var language: Language = .english{
        didSet{
            updateSpeechRecognizer()
        }
    }
    
    override init(){
        super.init()
        updateSpeechRecognizer()
        
        Task(priority: .background) {
            do{
                guard recognizer != nil else { throw RecognizerError.nilRecognizer }
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else { throw RecognizerError.notAuthorizedToRecognize }
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else { throw RecognizerError.notPermittedToRecord }
            }
            catch{
                speakError(error)
            }
        }
    }
    
    deinit {
        reset()
    }
    
    func updateSpeechRecognizer(){
        recognizer = SFSpeechRecognizer(locale: Locale.init(identifier: language.message))
        recognizer?.delegate = self
    }
    
    private static func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest){
        let audioEngine = AVAudioEngine()
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.playAndRecord, mode: .measurement, options: .duckOthers)
        
        try audioSession.setMode(.default)
        try audioSession.setPreferredSampleRate(44100)
        try audioSession.setPreferredIOBufferDuration(0.005)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        let inputNode = audioEngine.inputNode
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
            (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            request.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()
        
        return (audioEngine, request)
    }
    
    func startTrascribe(){
        DispatchQueue(label: "Speech Recognizer Queue", qos: .background).async { [weak self] in
            guard let self = self, let recognizer = self.recognizer, recognizer.isAvailable else {
                self?.speakError(RecognizerError.recognizerIsUnavailable)
                return
            }
            
            do{
                let (audioEngine, request) = try Self.prepareEngine()
                self.audioEngine = audioEngine
                self.request = request
                
                self.task = recognizer.recognitionTask(with: request) { result, error in
                    let receivedFinalResult = result?.isFinal ?? false
                    let receivedError = error != nil // != nil mean there's error (true)
                    
                    if receivedFinalResult || receivedError {
                        audioEngine.stop()
                        audioEngine.inputNode.removeTap(onBus: 0)
                    }
                    
                    if let result = result {
                        self.speak(result.bestTranscription.formattedString)
                    }
                }
            } catch {
                self.reset()
                self.speakError(error)
            }
        }
    }
    
    private func speak(_ message: String){
        DispatchQueue.main.async {
            self.transcript = message
        }
    }
    
    func stopTrascribe(){
        reset()
    }
    
    func reset(){
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
    }
    
    private func speakError(_ error: Error){
        var errorMessage = " "
        if let error = error as? RecognizerError{
            errorMessage += error.message
        }
        else{
            errorMessage += error.localizedDescription
        }
        
        DispatchQueue.main.async{
            self.transcript = "<< \(errorMessage) >>"
        }
    }
    
    //MARK: Enum per gli errori
    enum RecognizerError: Error {
        case nilRecognizer
        case notAuthorizedToRecognize
        case notPermittedToRecord
        case recognizerIsUnavailable
        
        var message: String {
            switch self {
            case .nilRecognizer: return "Can't initialize speech recognizer"
            case .notAuthorizedToRecognize: return "Not authorized to recognize speech"
            case .notPermittedToRecord: return "Not permitted to record audio"
            case .recognizerIsUnavailable: return "Recognizer is unavailable"
            }
        }
    }
    
    //MARK: Enum per i linguaggi
    enum Language: String, CaseIterable {
        case italian
        case english
        case spanish
        
        var message: String {
            switch self {
            case .italian: return "it-IT"
            case .english: return "en_US"
            case .spanish: return "es-ES"
            }
        }
    }
}


extension SFSpeechRecognizer {
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation { continuation in
            requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
}

extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            AVAudioApplication.requestRecordPermission(completionHandler: { authorized in
                continuation.resume(returning: authorized)
            })
        }
    }
}
