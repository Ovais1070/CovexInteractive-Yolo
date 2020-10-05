//
//  SocketAndRTC.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 8/24/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation
import Starscream
import WebRTC
import UIKit



class CustomSocket: WebSocketDelegate, WebRTCClientDelegate {
    
    
    
    static let instance = CustomSocket()
    
    //WebRtC and WebSocket
    var webRTCClient: WebRTCClient!
    var socket: WebSocket!
    var tryToConnectWebSocket: Timer!
    public var diction = [String: Any]()
    public var text = ""
    
    
    
    
    func connect() {
        
//        webRTCClient = WebRTCClient()
//             //  webRTCClient.delegate = self
//
//         socket = WebSocket(url: URL(string: socketUrl)!)
//              socket.delegate = self
//
//              tryToConnectWebSocket = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
//                  if  self.socket.isConnected {
//                      return
//                  }
//              self.socket.connect()
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                   print("Code Has been Run")
//                  //  self.registerlocal()
//                     self.registerlocal()
//
//                }
//                
////              self.registerlocal()
//              })
//        print("Connecting from custm class")
    }
    
    
    
    
     //WEB SOCKET
        func websocketDidConnect(socket: WebSocketClient) {
            print("-- websocket did connect --")
        }
        func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
            print("-- websocket did disconnect --")
        }
        func websocketDidConnect(ws: WebSocket) {
            print("websocket is connected")
        }
        func websocketDidDisconnect(ws: WebSocket, error: NSError?) {
             print("websocket is disconnected: \(error?.localizedDescription)")
        }
        func websocketDidReceiveMessage(ws: WebSocket, text: String) {
          //  print("Received text: \(text)")
        }

        func websocketDidReceiveData(ws: WebSocket, data: NSData) {
             print("Received data: \(data.length)")
        }

        func websocketDidReceivePong(socket: WebSocket) {
            print("Got pong!")
        }
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
        func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
            
            
            
          print("Received text server: \(text)")

            let dict = convertToDictionary(text: text)
           
            diction = dict ?? [:]
            CustomSocket.instance.diction = diction
            CustomSocket.instance.text = text
            var sdp = ""
            print("convertToDictionaryconvertToDictionary",diction ?? {})
            
            
            
             if let answer = dict?["answer"] as? [String: Any] {
                                 
                                if let sdpp = answer["sdp"] as? String {

                                    
                                    
                                    sdp = sdpp

                                }
                   }
                    if let yield = dict?["offer"] as? [String: Any] {
                         
                        if let sdpp = yield["sdp"] as? String {

                            
                            
                            sdp = sdpp

                        }
                }
            
            if let type = dict?["type"] as? String {
                 if type == "offer" {
                              
//          NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
                    
                    
//                               webRTCClient.receiveOffer(offerSDP: RTCSessionDescription(type: .offer, sdp: sdp), onCreateAnswer: {(answerSDP: RTCSessionDescription) -> Void in
////
//                                  self.sendSDP(sessionDescription: answerSDP)
//                             })
                           }
//                else if type == "answer" {
//
//                    print("Received text answer: \(sdp)")
//
//                               webRTCClient.receiveAnswer(answerSDP: RTCSessionDescription(type: .answer, sdp: sdp))
//                           }
                           
//                           else if type == "candidate" {
//
//                                do{
//                       let ssignalingMessage = try JSONDecoder().decode(receiveUserCandidate.self, from: text.data(using: .utf8)!)
//
//                            let candidate = ssignalingMessage.candidate
//
//                            print("Received text candidate: \(text)")
//
//                                    webRTCClient.receiveCandidate(candidate: RTCIceCandidate(sdp: candidate.candidate, sdpMLineIndex: candidate.sdpMLineIndex, sdpMid: candidate.sdpMid))
//                                }
//                                catch{
//                                             print("erroriscandidate",error)
//                                         }
//                }
            }
            
        }
    
    
    
    
    
    
    
        
        func websocketDidReceiveData(socket: WebSocketClient, data: Data) { }
    
    func registerlocal(){
               
               let datafield : [String:Any] = ["type":"login","name": "923316519503"]


                                 //  let data = try? JSONSerialization.data(withJSONObject: datafield)
                                   var error : NSError?
                                   let jsonData = try! JSONSerialization.data(withJSONObject: datafield, options: JSONSerialization.WritingOptions.prettyPrinted)
                                   let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String

                                   print(jsonString)

                         self.socket.write(string: jsonString)
           }
    
    
    
    
       // MARK: - WebRTC Signaling
//       private func sendSDP(sessionDescription: RTCSessionDescription){
//           var type = ""
//           if sessionDescription.type == .offer {
//               type = "offer"
//          
//           
//           }else if sessionDescription.type == .answer {
//               type = "answer"
//          
//           }
//           
//         //  sdk observer
//           
//           let sdp = SDP.init(sdp: sessionDescription.sdp)
//           let useroffer = offer.init(sdp: sessionDescription.sdp , type: type)
//
//           let signalingMessage = SignalingMessagee.init(type: type, name: "923072803568", answer: useroffer, candidate: nil)
//           do {
//               let data = try JSONEncoder().encode(signalingMessage)
//               let message = String(data: data, encoding: String.Encoding.utf8)!
//               
//                print("sdpsdpsdp",message)
//
//               if self.socket.isConnected {
//                   self.socket.write(string: message)
//               }
//           }catch{
//               print(error)
//           }
//       }
       
       private func sendCandidate(iceCandidate: RTCIceCandidate){
          // let candidate = Candidate.init(sdp: iceCandidate.sdp, sdpMLineIndex: iceCandidate.sdpMLineIndex, sdpMid: iceCandidate.sdpMid!, name: "nomiuser")

           
           let candidate = CandidateNew.init(candidate: iceCandidate.sdp, sdpMLineIndex: iceCandidate.sdpMLineIndex, sdpMid: iceCandidate.sdpMid!)
           
    
           
    
           let signalingMessage = sendUserCandidate.init(candidate: candidate, type: "candidate" , name: "923072803568")
           
           
           
           
           
           do {
               let data = try JSONEncoder().encode(signalingMessage)
               let message = String(data: data, encoding: String.Encoding.utf8)!
               print("signalingMessagecandidate",message )

               if self.socket.isConnected {
                   self.socket.write(string: message)
               }
           }catch{
               print(error)
           }
       }
    
    
    
    func didGenerateCandidate(iceCandidate: RTCIceCandidate) {
           self.sendCandidate(iceCandidate: iceCandidate)
       }
       
       func didIceConnectionStateChanged(iceConnectionState: RTCIceConnectionState) {
           var state = ""
           
           switch iceConnectionState {
           case .checking:
               state = "checking..."
           case .closed:
               state = "closed"
           case .completed:
               state = "completed"
           case .connected:
               state = "connected"
           case .count:
               state = "count..."
           case .disconnected:
               state = "disconnected"
           case .failed:
               state = "failed"
           case .new:
               state = "new..."
           }
//           self.webRTCStatusLabel.text = self.webRTCStatusMesasgeBase + state
       }
       
       func didConnectWebRTC() {
//           self.webRTCStatusLabel.textColor = .green
           // MARK: Disconnect websocket
          // self.socket.disconnect()
       }
       
       func didDisconnectWebRTC() {
//           self.webRTCStatusLabel.textColor = .red
       }
       
       func didOpenDataChannel() {
           print("did open data channel")
       }
       
       func didReceiveData(data: Data) {
//           if data == likeStr.data(using: String.Encoding.utf8) {
//               self.startLikeAnimation()
//           }
       }
       
       func didReceiveMessage(message: String) {
//           self.webRTCMessageLabel.text = message
       }
    
    
    
    
}
