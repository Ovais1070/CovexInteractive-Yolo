//
//  SocketRTC.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 9/4/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation
import Starscream
import WebRTC
import UIKit



//class CustomSocket: UIView, WebSocketDelegate, WebRTCClientDelegate , CameraSessionDelegate{
//    
//    func didOutput(_ sampleBuffer: CMSampleBuffer) {
//           if self.useCustomCapturer {
//               if let cvpixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer){
//
//               if let buffer = self.cameraFilter?.apply(cvpixelBuffer){
//                       self.webRTCClient.captureCurrentFrame(sampleBuffer: buffer)
//                   }
//
//               else{
//                       print("no applied image")
//                   }
//               }
//
//               else{
//                   print("no pixelbuffer")
//               }
//               //            self.webRTCClient.captureCurrentFrame(sampleBuffer: buffer)
//           }
//       }
//    
//    static let instance = CustomSocket()
//    
//    
//    
//    
//    var webRTCClient: WebRTCClient!
//    var socket: WebSocket!
//    var tryToConnectWebSocket: Timer!
//    var cameraSession: CameraSession?
//    
//
//    // You can create video source from CMSampleBuffer :)
//    var useCustomCapturer: Bool = true
//    var cameraFilter: CameraFilter?
//
//    // Constants
//    let ipAddress: String = "192.168.1.139"
//    let wsStatusMessageBase = "WebSocket: "
//    let webRTCStatusMesasgeBase = "WebRTC: "
//    let likeStr: String = "Like"
//
//    // UI
//    var wsStatusLabel: UILabel!
//    var webRTCStatusLabel: UILabel!
//    var webRTCMessageLabel: UILabel!
//    var likeImage: UIImage!
//    var likeImageViewRect: CGRect!
//
//    
//    //WebRtC and WebSocket
//    public var diction = [String: Any]()
//    public var text = ""
//    
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    
//
//    
//    
//    //let window = UIApplication.shared.keyWindow!
//    let v = UIView()
//    
//    
//    
//    func connect() {
//        
//        #if targetEnvironment(simulator)
//                // simulator does not have camera
//                self.useCustomCapturer = false
//                #endif
//
//                webRTCClient = WebRTCClient()
//                webRTCClient.delegate = self
//                webRTCClient.setup(videoTrack: true, audioTrack: true, dataChannel: true, customFrameCapturer: useCustomCapturer)
//
//                if useCustomCapturer {
//                    print("--- use custom capturer ---")
//                    self.cameraSession = CameraSession()
//                    self.cameraSession?.delegate = self
//                    self.cameraSession?.setupSession()
//
//                    self.cameraFilter = CameraFilter()
//                }
//
//            //  //  socket = WebSocket(url: URL(string: "ws://" + ipAddress + ":8080/")!)
//
//                socket = WebSocket(url: URL(string: socketUrl)!)
//
//                socket.delegate = self
//
//
//        //        socket.onText = { (text: String) in
//        //            print("got some text: \(text)")
//        //        }
//        //        //websocketDidReceiveData
//        //        socket.onData = { (data: Data) in
//        //             print("got some data: \(data.count)")
//        //        }
//
//
//                tryToConnectWebSocket = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
//                    if self.webRTCClient.isConnected || self.socket.isConnected {
//                        return
//                    }
//
//
//
//
//
//                    self.socket.connect()
//
//
//
//
//
//
//
//                 //   socket.emit("updateLocation",  data!)
//
//
//                })
//    }
//    
//     private func setupUI(){
//        
//        v.frame = appDelegate.window?.bounds as! CGRect
//        appDelegate.window?.addSubview((v))
//     //   v.backgroundColor = UIColor.black
//     //   let v2 = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 50))
//     //   v2.backgroundColor = UIColor.white
//       // v.addSubview(v2)
//        
//        
//        
//        
//            let remoteVideoViewContainter = UIView(frame: CGRect(x: 0, y: 0, width: ScreenSizeUtil.width(), height: ScreenSizeUtil.height()*0.7))
//            remoteVideoViewContainter.backgroundColor = .gray
//            v.addSubview(remoteVideoViewContainter)
//
//            let remoteVideoView = webRTCClient.remoteVideoView()
//            webRTCClient.setupRemoteViewFrame(frame: CGRect(x: 0, y: 0, width: ScreenSizeUtil.width()*0.7, height: ScreenSizeUtil.height()*0.7))
//            remoteVideoView.center = remoteVideoViewContainter.center
//            remoteVideoViewContainter.addSubview(remoteVideoView)
//
//            let localVideoView = webRTCClient.localVideoView()
//            webRTCClient.setupLocalViewFrame(frame: CGRect(x: 0, y: 0, width: ScreenSizeUtil.width()/3, height: ScreenSizeUtil.height()/3))
//            localVideoView.center.y = v.center.y
//            localVideoView.subviews.last?.isUserInteractionEnabled = true
//            v.addSubview(localVideoView)
//
//            let localVideoViewButton = UIButton(frame: CGRect(x: 0, y: 0, width: localVideoView.frame.width, height: localVideoView.frame.height))
//            localVideoViewButton.backgroundColor = UIColor.clear
//            localVideoViewButton.addTarget(self, action: #selector(self.localVideoViewTapped(_:)), for: .touchUpInside)
//            localVideoView.addSubview(localVideoViewButton)
//
//            let likeButton = UIButton(frame: CGRect(x: remoteVideoViewContainter.right - 50, y: remoteVideoViewContainter.bottom - 50, width: 40, height: 40))
//            likeButton.backgroundColor = UIColor.clear
//            likeButton.addTarget(self, action: #selector(self.likeButtonTapped(_:)), for: .touchUpInside)
//            v.addSubview(likeButton)
//            likeButton.setImage(UIImage(named: "like_border.png"), for: .normal)
//
//            likeImage = UIImage(named: "like_filled.png")
//            likeImageViewRect = CGRect(x: remoteVideoViewContainter.right - 70, y: likeButton.top - 70, width: 60, height: 60)
//
//            let messageButton = UIButton(frame: CGRect(x: likeButton.left - 220, y: remoteVideoViewContainter.bottom - 50, width: 210, height: 40))
//            messageButton.setBackgroundImage(UIColor.green.rectImage(width: messageButton.frame.width, height: messageButton.frame.height), for: .normal)
//            messageButton.addTarget(self, action: #selector(self.sendMessageButtonTapped(_:)), for: .touchUpInside)
//            messageButton.titleLabel?.adjustsFontSizeToFitWidth = true
////            messageButton.setTitle(messageType.greet.text(), for: .normal)
//            messageButton.layer.cornerRadius = 20
//            messageButton.layer.masksToBounds = true
//            v.addSubview(messageButton)
//
//            wsStatusLabel = UILabel(frame: CGRect(x: 0, y: remoteVideoViewContainter.bottom, width: ScreenSizeUtil.width(), height: 30))
//            wsStatusLabel.textAlignment = .center
//            v.addSubview(wsStatusLabel)
//            webRTCStatusLabel = UILabel(frame: CGRect(x: 0, y: wsStatusLabel.bottom, width: ScreenSizeUtil.width(), height: 30))
//            webRTCStatusLabel.textAlignment = .center
//            webRTCStatusLabel.text = webRTCStatusMesasgeBase + "initialized"
//            v.addSubview(webRTCStatusLabel)
//            webRTCMessageLabel = UILabel(frame: CGRect(x: 0, y: webRTCStatusLabel.bottom, width: ScreenSizeUtil.width(), height: 30))
//            webRTCMessageLabel.textAlignment = .center
//            v.addSubview(webRTCMessageLabel)
//
//            let buttonWidth = ScreenSizeUtil.width()*0.4
//            let buttonHeight: CGFloat = 60
//            let buttonRadius: CGFloat = 30
//            let callButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight))
//            callButton.setBackgroundImage(UIColor.blue.rectImage(width: callButton.frame.width, height: callButton.frame.height), for: .normal)
//            callButton.layer.cornerRadius = buttonRadius
//            callButton.layer.masksToBounds = true
//            callButton.center.x = ScreenSizeUtil.width()/4
//            callButton.center.y = webRTCStatusLabel.bottom + (ScreenSizeUtil.height() - webRTCStatusLabel.bottom)/2
//            callButton.setTitle("Call", for: .normal)
//            callButton.titleLabel?.font = UIFont.systemFont(ofSize: 23)
//            callButton.addTarget(self, action: #selector(self.callButtonTapped(_:)), for: .touchUpInside)
//            v.addSubview(callButton)
//
//            let hangupButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight))
//            hangupButton.setBackgroundImage(UIColor.red.rectImage(width: hangupButton.frame.width, height: hangupButton.frame.height), for: .normal)
//            hangupButton.layer.cornerRadius = buttonRadius
//            hangupButton.layer.masksToBounds = true
//            hangupButton.center.x = ScreenSizeUtil.width()/4 * 3
//            hangupButton.center.y = callButton.center.y
//            hangupButton.setTitle("hang up" , for: .normal)
//            hangupButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
//            hangupButton.addTarget(self, action: #selector(self.hangupButtonTapped(_:)), for: .touchUpInside)
//            v.addSubview(hangupButton)
//        }
//
//        // MARK: - UI Events
//        @objc func callButtonTapped(_ sender: UIButton){
//            if !webRTCClient.isConnected {
//                webRTCClient.connect(onSuccess: { (offerSDP: RTCSessionDescription) -> Void in
//
//                    self.sendSDP(sessionDescription: offerSDP)
//
//                })
//            }
//        }
//
//        @objc func hangupButtonTapped(_ sender: UIButton){
//            if webRTCClient.isConnected {
//                webRTCClient.disconnect()
//            }
//        }
//
//        @objc func sendMessageButtonTapped(_ sender: UIButton){
//            webRTCClient.sendMessge(message: (sender.titleLabel?.text!)!)
////            if sender.titleLabel?.text == messageType.greet.text() {
////                sender.setTitle(messageType.introduce.text(), for: .normal)
////            }else if sender.titleLabel?.text == messageType.introduce.text() {
////                sender.setTitle(messageType.greet.text(), for: .normal)
////            }
//        }
//
//        @objc func likeButtonTapped(_ sender: UIButton){
//
//
//            let datafield : [String:Any] = ["type":"login","name": "923316519503"]
//
//
//                              //  let data = try? JSONSerialization.data(withJSONObject: datafield)
//                                var error : NSError?
//                                let jsonData = try! JSONSerialization.data(withJSONObject: datafield, options: JSONSerialization.WritingOptions.prettyPrinted)
//                                let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
//
//                                print(jsonString)
//
//                      self.socket.write(string: jsonString)
//
//
//
//    //        let data = likeStr.data(using: String.Encoding.utf8)
//    //        webRTCClient.sendData(data: data!)
//    //        self.cameraFilter?.changeFilter((cameraFilter?.filterType.next())!)
//        }
//
//        @objc func localVideoViewTapped(_ sender: UITapGestureRecognizer) {
//            if let filter = self.cameraFilter {
//                filter.changeFilter(filter.filterType.next())
//            }
//        }
//
//
//            @IBAction func loudSpeaker(_ sender: Any) {
//
//        //        self.registerlocal()
//            }
//
//            @IBAction func videoOnOff(_ sender: Any) {
//    //            CallUser()
//            }
//
//            @IBAction func micOnOff(_ sender: Any) {
//    //            receivingCall()
//
//            }
//
//
//        private func startLikeAnimation(){
//            
//            
//            
//            let likeImageView = UIImageView(frame: likeImageViewRect)
//            likeImageView.backgroundColor = UIColor.clear
//            likeImageView.contentMode = .scaleAspectFit
//            likeImageView.image = likeImage
//            likeImageView.alpha = 1.0
//            v.addSubview(likeImageView)
//            UIView.animate(withDuration: 0.5, animations: {
//                likeImageView.alpha = 0.0
//            }) { (reuslt) in
//                likeImageView.removeFromSuperview()
//            }
//        }
//
//        // MARK: - WebRTC Signaling
//        private func sendSDP(sessionDescription: RTCSessionDescription){
//            var type = ""
//            if sessionDescription.type == .offer {
//                type = "offer"
//
//
//            }else if sessionDescription.type == .answer {
//                type = "answer"
//
//            }
//
//          //  sdk observer
//
//            let sdp = SDP.init(sdp: sessionDescription.sdp)
//            let useroffer = offer.init(sdp: sessionDescription.sdp , type: type)
//
//            let signalingMessage = SignalingMessagee.init(type: type, name: "923072803568", answer: useroffer, candidate: nil)
//            do {
//                let data = try JSONEncoder().encode(signalingMessage)
//                let message = String(data: data, encoding: String.Encoding.utf8)!
//
//                 print("sdpsdpsdp",message)
//
//                if self.socket.isConnected {
//                    self.socket.write(string: message)
//                }
//            }catch{
//                print(error)
//            }
//        }
//
//        private func sendCandidate(iceCandidate: RTCIceCandidate){
//           // let candidate = Candidate.init(sdp: iceCandidate.sdp, sdpMLineIndex: iceCandidate.sdpMLineIndex, sdpMid: iceCandidate.sdpMid!, name: "nomiuser")
//
//
//            let candidate = CandidateNew.init(candidate: iceCandidate.sdp, sdpMLineIndex: iceCandidate.sdpMLineIndex, sdpMid: iceCandidate.sdpMid!)
//
//
//
//
//            let signalingMessage = sendUserCandidate.init(candidate: candidate, type: "candidate" , name: "923072803568")
//
//
//
//
//
//            do {
//                let data = try JSONEncoder().encode(signalingMessage)
//                let message = String(data: data, encoding: String.Encoding.utf8)!
//                print("signalingMessagecandidate",message )
//
//                if self.socket.isConnected {
//                    self.socket.write(string: message)
//
//                }
//            }catch{
//                print(error)
//            }
//        }
//    
//    
//     //WEB SOCKET
//        func websocketDidConnect(socket: WebSocketClient) {
//            print("-- websocket did connect --")
//            
//            
//            
//            
//        }
//        func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
//            print("-- websocket did disconnect --")
//            
//            
//            
//        }
//        func websocketDidConnect(ws: WebSocket) {
//            print("websocket is connected")
//        }
//        func websocketDidDisconnect(ws: WebSocket, error: NSError?) {
//             print("websocket is disconnected: \(error?.localizedDescription)")
//        }
//        func websocketDidReceiveMessage(ws: WebSocket, text: String) {
//          //  print("Received text: \(text)")
//        }
//
//        func websocketDidReceiveData(ws: WebSocket, data: NSData) {
//             print("Received data: \(data.length)")
//        }
//
//        func websocketDidReceivePong(socket: WebSocket) {
//            print("Got pong!")
//        }
//        func convertToDictionary(text: String) -> [String: Any]? {
//            if let data = text.data(using: .utf8) {
//                do {
//                    return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//            return nil
//        }
//        
//        func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
//    
//    
//          print("Received text server: \(text)")
//    
//           let dict = convertToDictionary(text: text)
//           //
//           //
//           //
//    
//          var sdp = ""
//    
//          print("convertToDictionaryconvertToDictionary",dict ?? {})
//    
//             if let answer = dict?["answer"] as? [String: Any] {
//    
//             if let sdpp = answer["sdp"] as? String
//    
//    
//             {
//    
//                 sdp = sdpp
//    
//             }
//    
//            }
//    
//                    if let yield = dict?["offer"] as? [String: Any] {
//    
//                        if let sdpp = yield["sdp"] as? String {
//    
//    
//    
//                            sdp = sdpp
//    
//                        }
//            //
//            //
//                                 }
//    
//            if let type = dict?["type"] as? String {
//                 if type == "offer" {
//    
//                            webRTCClient.receiveOffer(offerSDP: RTCSessionDescription(type: .offer, sdp: sdp), onCreateAnswer: {(answerSDP: RTCSessionDescription) -> Void in
//    
//                            self.sendSDP(sessionDescription: answerSDP)
//    
//                            })
//                           }else if type == "answer" {
//    
//                    print("Received text answer: \(sdp)")
//    
//                               webRTCClient.receiveAnswer(answerSDP: RTCSessionDescription(type: .answer, sdp: sdp))
//                           }
//    
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
//    
//    
//    
//    
//            }
//    
//    
//    
//    
//    
//    
//    
//    
//    //        do{
//    //
//    //
//    //            let signalingMessage = try JSONDecoder().decode(SignalingMessagee.self, from: text.data(using: .utf8)!)
//    //            print("Received text signalingMessage: \(signalingMessage)")
//    //
//    //
//    //
//    //            if signalingMessage.type == "offer" {
//    //
//    //                webRTCClient.receiveOffer(offerSDP: RTCSessionDescription(type: .offer, sdp: sdp), onCreateAnswer: {(answerSDP: RTCSessionDescription) -> Void in
//    //
//    //                    self.sendSDP(sessionDescription: answerSDP)
//    //              })
//    //            }else if signalingMessage.type == "answer" {
//    //
//    //                webRTCClient.receiveAnswer(answerSDP: RTCSessionDescription(type: .answer, sdp: sdp))
//    //            }
//    //
//    //            else if signalingMessage.type == "candidate" {
//    //                if let candidate = dict?["candidate"] as? [String: Any] {
//    //
//    //                    print("Received text candidate: \(candidate)")
//    //
//    //                }
//    //
//    //
//    ////                let candidate = Candidate.init(sdp: sessionDescription.sdp , type: type)
//    //
//    //
//    ////                let candidate = SignalingMessagee.candidate!
//    ////
//    ////                print("Received text candidate: \(candidate)")
//    ////
//    ////                webRTCClient.receiveCandidate(candidate: RTCIceCandidate(sdp: candidate.sdp, sdpMLineIndex: candidate.sdpMLineIndex, sdpMid: candidate.sdpMid))
//    //            }
//    //        }catch{
//    //            print("erroris",error)
//             }
//    
//        }
//    
//    
//    
//    
//    
//    
//        
//        func websocketDidReceiveData(socket: WebSocketClient, data: Data) { }
//    
//    func registerlocal(){
//               
//               let datafield : [String:Any] = ["type":"login","name": "923316519503"]
//
//
//                                 //  let data = try? JSONSerialization.data(withJSONObject: datafield)
//                                   var error : NSError?
//                                   let jsonData = try! JSONSerialization.data(withJSONObject: datafield, options: JSONSerialization.WritingOptions.prettyPrinted)
//                                   let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
//
//                                   print(jsonString)
//
//                         self.socket.write(string: jsonString)
//           }
//    
//    
//    
//    
//      
//       
//       
//    
//    
//    
//    func didGenerateCandidate(iceCandidate: RTCIceCandidate) {
//           self.sendCandidate(iceCandidate: iceCandidate)
//       }
//       
//       func didIceConnectionStateChanged(iceConnectionState: RTCIceConnectionState) {
//           var state = ""
//           
//           switch iceConnectionState {
//           case .checking:
//               state = "checking..."
//           case .closed:
//               state = "closed"
//           case .completed:
//               state = "completed"
//           case .connected:
//               state = "connected"
//           case .count:
//               state = "count..."
//           case .disconnected:
//               state = "disconnected"
//           case .failed:
//               state = "failed"
//           case .new:
//               state = "new..."
//           }
////           self.webRTCStatusLabel.text = self.webRTCStatusMesasgeBase + state
//         print("webRTCStatusLabel", state)
//       }
//       
//       func didConnectWebRTC() {
////           self.webRTCStatusLabel.textColor = .green
//           // MARK: Disconnect websocket
//          // self.socket.disconnect()
//       }
//       
//       func didDisconnectWebRTC() {
////           self.webRTCStatusLabel.textColor = .red
//       }
//       
//       func didOpenDataChannel() {
//           print("did open data channel")
//       }
//       
//       func didReceiveData(data: Data) {
////           if data == likeStr.data(using: String.Encoding.utf8) {
////               self.startLikeAnimation()
////           }
//       }
//       
//       func didReceiveMessage(message: String) {
////           self.webRTCMessageLabel.text = message
//       }
//    
//    
//    
//    
//}

