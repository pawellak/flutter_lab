//
//  AppDelegate+Channels.swift
//  Runner
//
//  Created by Paweł Łąk on 02/07/2025.
//

extension AppDelegate : MessageApi,GreatApi {
    func greet(message: String) throws -> String {
        return "Hello \(message)"
    }
    
    func getMessageFromNative(message: String, completion: @escaping (Result<String, any Error>) -> Void) {
        let response = "Hello \(message)"
        completion(.success("This is native message \(response)"))
    }
    
    func setupFlutter(_ controller : FlutterViewController) {
        MessageApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: self)
        GreatApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: self)
        
        let reverseApi = ReverseMessageApi(binaryMessenger: controller.binaryMessenger)
        
        reverseApi.getMessageFromFlutter(message: "I am message from IOS Native") {
            result in print("Received from Flutter")
        }
    }
}
