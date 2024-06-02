//
//  FileSystemManager.swift
//  Deaf
//
//  Created by Davide Galdiero on 31/05/24.
//

import Foundation

class FileSystemManager{
    enum FSError: Error{
        case failedToGetDocumentDir
        case failedToGetRecordingsDir
        case failedToCreateRecordingsDir
        case failedToSaveRecording
    }
    
    static var documentDirectory: URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    static func getRecordingTempURL() -> URL{
        let tempDir = FileManager.default.temporaryDirectory
        let filePath = "tempRecording.caf"
        return tempDir.appendingPathComponent(filePath)
    }
    
    static func getRecordingsDirectoryURL() -> URL? {
        guard let dir = documentDirectory else { return nil }
        return dir.appending(path: "recordings")
    }
    
    static func makeRecordingsDirectory() throws {
        guard let dir = documentDirectory else {throw FSError.failedToGetDocumentDir}
        
        do {
            try FileManager.default.createDirectory(at: dir.appending(path: "recordings"), withIntermediateDirectories: true)
        }
        catch{
            throw FSError.failedToCreateRecordingsDir
        }
    }
    
    static func isRecordingsDirectoryPresent() -> Bool{
        guard let recordingsDirectoryURL = self.getRecordingsDirectoryURL() else { return false }
        var isDirectory: ObjCBool = false
        return FileManager.default.fileExists(atPath: recordingsDirectoryURL.relativePath, isDirectory: &isDirectory) && isDirectory.boolValue
    }
    
    static func saveRecordingFile() -> (Data?, String?) {
        let recordingTempURL = getRecordingTempURL()
        let fileName = UUID().uuidString + "." + recordingTempURL.pathExtension
        
        if(!self.isRecordingsDirectoryPresent()){
            do{
                try self.makeRecordingsDirectory()
            }
            catch{
                return (nil, nil)
            }
        }
        
        guard let recordingsDir = self.getRecordingsDirectoryURL() else {return (nil, nil)}
        let target = recordingsDir.appending(path: fileName)
        
        do {
            try FileManager.default.moveItem(at: recordingTempURL, to: target)
        }
        catch {
            return (nil, nil)
        }
        
        guard let audioData = try? Data(contentsOf: target) else {
            print("Impossibile convertire il file")
            return (nil, nil)
        }
        
        return (audioData, fileName)
    }
    
    static func getRecordingURL(_ fileName: String) -> URL? {
        guard let dir = getRecordingsDirectoryURL() else {return nil}
        return dir.appendingPathComponent(fileName)
    }
    
}
