//
//  SocketClient.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 9/17/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation
import Starscream
import WebRTC

class SocketClient: WebSocketDelegate {
    
    var socket: WebSocket!
    
    private static var sharedInstance: SocketClient = {
        let instance = SocketClient()
        // Configuration
        // ...
        
        return instance
    }()
    
    // MARK: - Accessors
    
    class func instance() -> SocketClient {
        return sharedInstance
    }
    
    //MARK:- Socket Connect Method
    
    func connect() {
        
        socket = WebSocket(url: URL(string: socketUrl)!)
        socket.delegate = self
        
        if  self.socket.isConnected {
            return
        }
        self.socket.connect()
    }
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("Socket - websocketDidConnect()")
        self.registerlocal(socket)
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("Socket - websocketDidDisconnect() \(String(describing: error?.localizedDescription))")
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("Socket - websocketDidReceiveData(): \(data)")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("Socket - websocketDidReceiveMessage(): \(text)")
        onMessageReceived(text)
//        let dict = convertToDictionary(text: text) ?? [:]
//
//        if let type = dict["type"] as? String {
//            if type == "candidate" {
//                 do{
//                    let ssignalingMessage = try JSONDecoder().decode(receiveUserCandidate.self, from: text.data(using: .utf8)!)
//
//                    let candidate = ssignalingMessage.candidate
//
//                    print("Received text candidate: \(text)")
//
//                    WebRTCClient.instance().receiveCandidate(candidate: RTCIceCandidate(sdp: candidate.candidate, sdpMLineIndex: candidate.sdpMLineIndex, sdpMid: candidate.sdpMid))
//                 }
//                 catch{
//                    print("erroriscandidate",error)
//                }
//            }
//        }
        
        
        
        
    }
    
    //MARK:- Register Local Method
    
    func registerlocal(_ socket: WebSocketClient){
        
        let datafield : [String:Any] = [
            "type": "login",
            "name": "923316519503"
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: datafield, options: JSONSerialization.WritingOptions.prettyPrinted)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        
        print(jsonString)
        
        socket.write(string: jsonString)
    }
    
    func onMessageReceived(_ text: String) {
        let dict = convertToDictionary(text: text) ?? [:]
        
        if let type = dict["type"] as? String {
            if type == "offer" {    // Incoming call
                if let yield = dict["offer"] as? [String: Any] {

                    if let sdp = yield["sdp"] as? String {

                      WebRTCClient.instance().setup(videoTrack: true, audioTrack: true, dataChannel: true, customFrameCapturer: false)
                        WebRTCClient.instance().receiveOffer(offerSDP: RTCSessionDescription(type: .offer, sdp: sdp), onCreateAnswer: {(answerSDP: RTCSessionDescription) -> Void in
                            WebRTCClient.instance().answerSDP = answerSDP                            
                        })
                    }
                }
               
                print("DictDictDict", dict["data"])

                
                NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: dict)
            } else if type == "answer" {   // End call
                
            } else if type == "cancel" {   // End call
                
            } else if type == "candidate" {
                
                if let candidate = dict["candidate"] as? [String: Any] {

                    print("Received candidate: \(candidate)")
                    
                    let candidatee = candidate["candidate"] as! String
                    let sdpMLineIndex = candidate["sdpMLineIndex"] as! Int32
                    let sdpMid = candidate["sdpMid"] as! String
                    
                    WebRTCClient.instance().receiveCandidate(candidate: RTCIceCandidate(sdp: candidatee, sdpMLineIndex: sdpMLineIndex, sdpMid: sdpMid))
                }
            }
        }
    }
    
    //MARK:- Convert To Dictionary Method
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func sendSDP(sessionDescription: RTCSessionDescription){
        var type = ""
        if sessionDescription.type == .offer {
            type = "offer"
        } else if sessionDescription.type == .answer {
            type = "answer"
        }
        
        //  sdk observer
        let sdp = SessionDescription.init(sdp: sessionDescription.sdp, type: type)
        let signalingMessage = SendCandidateType.init(type: type, name: WebRTCClient.instance().callingInfo!.name, answer: sdp, candidate: nil)
        do {
            let data = try JSONEncoder().encode(signalingMessage)
            let message = String(data: data, encoding: String.Encoding.utf8)!
            if socket.isConnected {
                socket.write(string: message)
            }
        }catch{
            print(error)
        }
    }
}

