//
//  ViewController.swift
//
//  Convex Vchat
//
//  Created by 1234 on 6/10/20.
//  Copyright © 2020 n0. All rights reserved.
//






import UIKit
import Starscream
import UIKit
import WebRTC
import ContactsUI


class CallViewController: UIViewController, WebSocketDelegate, WebRTCClientDelegate, CameraSessionDelegate {
    
    
    @IBOutlet weak var localVideoView: UIView!
    @IBOutlet weak var remoteVideoViewContainter: UIView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var endCall: UIButton!
    @IBOutlet weak var bottomPlate: UIView!
    
    @IBOutlet weak var acceptCall: UIButton!
    
    @IBOutlet weak var disconnectCall: UIButton!
    @IBOutlet weak var loudSpeaker: UIButton!
    @IBOutlet weak var videoCamera: UIButton!
    @IBOutlet weak var mic_onoff: UIButton!
    
    
    
    
    
    
    
    
    var service = CustomSocket.instance.socket
    var rtcService = CustomSocket.instance.webRTCClient
    var offerSdp = ""
    
    var open: Bool = true
    
//    var closed: Bool = false
    var contactVC = ContactsViewController()
    
    enum messageType {
        case greet
        case introduce
        
        func text() -> String {
            switch self {
            case .greet:
                return "Hello!"
            case .introduce:
                return "I'm " + UIDevice.modelName
            }
        }
    }
    
    //MARK: - Properties
    var webRTCClient: WebRTCClient!
    var socketClient: SocketClient!
    //var socket: WebSocket!
    var tryToConnectWebSocket: Timer!
    var cameraSession: CameraSession?
    
    // You can create video source from CMSampleBuffer :)
    var useCustomCapturer: Bool = true
    var cameraFilter: CameraFilter?
    
    // Constants
    let ipAddress: String = "192.168.1.139"
    let wsStatusMessageBase = "WebSocket: "
    let webRTCStatusMesasgeBase = "WebRTC: "
    let likeStr: String = "Like"
    
    // UI
    var wsStatusLabel: UILabel!
    var webRTCStatusLabel: UILabel!
    var webRTCMessageLabel: UILabel!
    var likeImage: UIImage!
    var likeImageViewRect: CGRect!
    
    //MARK: - ViewController Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        #if targetEnvironment(simulator)
        // simulator does not have camera
        self.useCustomCapturer = false
        #endif
        
        socketClient = SocketClient.instance()
        // Prepare webrtc client for calling
        webRTCClient = WebRTCClient.instance()
        webRTCClient?.delegate = self
        
        
        if webRTCClient.callingInfo!.isReceivingCall {
            // Receiving
            print("is recieveing call")

            // Step one before answering call
            acceptCall.makeCircular()
            disconnectCall.makeCircular()
            bottomPlate.isHidden = false
            endCall.isHidden = true
            loudSpeaker.isHidden = true
            videoCamera.isHidden = true
            mic_onoff.isHidden = true
            bottomPlate.backgroundColor = UIColor.clear
            //// Setting up view before recieveing call
//            setupLocalView()

//            localVideoView.layer.backgroundColor = #colorLiteral(red: 0.307271719, green: 0.01527413726, blue: 0.6460383534, alpha: 1)
            
            
            
            
            
            
        } else {
            // Calling
            print("is Calling")
            webRTCClient?.setup(videoTrack: true, audioTrack: true, dataChannel: true, customFrameCapturer: useCustomCapturer)
            //make offer for out going call
        }
        
        
        if useCustomCapturer {
            print("--- use custom capturer ---")
            self.cameraSession = CameraSession()
            self.cameraSession?.delegate = self
            self.cameraSession?.setupSession()
            
            self.cameraFilter = CameraFilter()
        }
        
        
        

        service?.delegate = self
        
        
        // Do any additional setup after loading the view, typically from a nib.
        //    setupLocalView()
        endCall.makeCircular()
        
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
//        remoteVideoViewContainter.addGestureRecognizer(tap)
        
//        tap.cancelsTouchesInView = false;
        
//        receivingCall()
        
        
        setupNavugationController()
        
        
    }
    
    func answerCall() {
        // Ansewring Call
        if let sdp = webRTCClient.answerSDP {
            self.socketClient?.sendSDP(sessionDescription: sdp)
            
            disconnectCall.isHidden = true
            acceptCall.isHidden = true
            endCall.isHidden = false
            loudSpeaker.isHidden  = false
            mic_onoff.isHidden = false
            videoCamera.isHidden = false
            setupLocalViewunactive()
            
            self.localVideoView.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            localVideoView.addGestureRecognizer(panGesture)
            
//            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
//                   remoteVideoViewContainter.addGestureRecognizer(tap)

//                 
            
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        setupLocalView()
    }
    override func viewDidAppear(_ animated: Bool) {

        self.setupUI()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavugationController(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        if self.navigationController == nil {
            return
        }
        
        let navView = UIView()
        
        // Create the label
        let label = UILabel()
        label.text = "Video Call"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.sizeToFit()
        label.center = navView.center
        label.textAlignment = NSTextAlignment.center
        
        // Create the image view
        let image = UIImageView()
        image.image = UIImage(named: "videocam-1")
        // To maintain the image's aspect ratio:
        let imageAspect = image.image!.size.width/image.image!.size.height
        // Setting the image frame so that it's immediately before the text:
        image.frame = CGRect(x: label.frame.origin.x-label.frame.size.height*imageAspect, y: label.frame.origin.y, width: label.frame.size.height*imageAspect, height: label.frame.size.height)
        image.contentMode = UIView.ContentMode.scaleAspectFit
        
        // Add both the label and image view to the navView
        navView.addSubview(label)
        navView.addSubview(image)
        
        // Set the navigation bar's navigation item's titleView to the navView
        self.navigationItem.titleView = navView
        
        // Set the navView's frame to fit within the titleView
        navView.sizeToFit()
    }
    
    func setupLocalView(){
        localVideoView.leftAnchor.constraint(equalTo: remoteVideoViewContainter.leftAnchor, constant: 0).isActive = true
        localVideoView.rightAnchor.constraint(equalTo: remoteVideoViewContainter.rightAnchor, constant: 0).isActive = true
        localVideoView.topAnchor.constraint(equalTo: remoteVideoViewContainter.topAnchor, constant: 0).isActive = true
        localVideoView.bottomAnchor.constraint(equalTo: remoteVideoViewContainter.bottomAnchor, constant: 0).isActive = true
    }
    
    
    func setupLocalViewunactive(){
        localVideoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = false
        localVideoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = false
        localVideoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = false
        localVideoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = false
    }
    
    
    // MARK: - UI
    private func setupUI(){
        
                let localVideoVieww = WebRTCClient.instance().localVideoView()
                WebRTCClient.instance().setupLocalViewFrame(frame: CGRect(x: 0, y: 0, width: self.localVideoView.frame.width, height: self.localVideoView.frame.height))
        
                self.localVideoView.addSubview(localVideoVieww)
        
        localVideoView = WebRTCClient.instance().localVideoView()
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height

        let remoteVideoViewContainters = WebRTCClient.instance().remoteVideoView()
        WebRTCClient.instance().setupRemoteViewFrame(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        
        self.remoteVideoViewContainter.addSubview(remoteVideoViewContainters)
        
  
    }
    
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        let statusFrame = UIApplication.shared.statusBarFrame
        
        if let senderView = sender.view {
            if senderView.frame.origin.x < 0.0 {
                senderView.frame.origin = CGPoint(x: 0.0, y: senderView.frame.origin.y)
            }
            if senderView.frame.origin.y < statusFrame.height {
                senderView.frame.origin = CGPoint(x: senderView.frame.origin.x, y: statusFrame.height)
            }
            if senderView.frame.origin.x + senderView.frame.size.width > view.frame.width {
                senderView.frame.origin = CGPoint(x: view.frame.width - senderView.frame.size.width, y: senderView.frame.origin.y)
            }
            if senderView.frame.origin.y + senderView.frame.size.height > view.frame.height {
                senderView.frame.origin = CGPoint(x: senderView.frame.origin.x, y: view.frame.height - senderView.frame.size.height)
            }
        }
        
        if let centerX = sender.view?.center.x, let centerY = sender.view?.center.y {
            sender.view?.center = CGPoint.init(x: centerX + translation.x , y: centerY + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
        }
    }
    
    @objc func handleTap(_ sender: UIPanGestureRecognizer) {
        
        
        if open == true {
            print("bring it down")
            UIView.animate(withDuration: 0.3) {
                self.bottomViewHeight.constant = 0
                self.open = false
                self.view.layoutIfNeeded()
            }
        } else {
            print("bring it up")
            UIView.animate(withDuration: 0.3) {
                self.bottomViewHeight.constant = 250
                self.open = true
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    
    
    func CallUser(){
        if !webRTCClient.isConnected {
            webRTCClient.connect(onSuccess: { (offerSDP: RTCSessionDescription) -> Void in
                
//                self.sendSDP(sessionDescription: offerSDP)
                
            })
        }
    }
    
    
    
    
    
    
    // MARK: - UI Events
    @objc func callButtonTapped(_ sender: UIButton){

    }
    
    @objc func hangupButtonTapped(_ sender: UIButton){
        //        if webRTCClient.isConnected {
        //            webRTCClient.disconnect()
        //        }
    }
    
    @objc func sendMessageButtonTapped(_ sender: UIButton){
        webRTCClient.sendMessge(message: (sender.titleLabel?.text!)!)
        if sender.titleLabel?.text == messageType.greet.text() {
            sender.setTitle(messageType.introduce.text(), for: .normal)
        }else if sender.titleLabel?.text == messageType.introduce.text() {
            sender.setTitle(messageType.greet.text(), for: .normal)
        }
    }
    
    
   
    
    @objc func localVideoViewTapped(_ sender: UITapGestureRecognizer) {
        if let filter = self.cameraFilter {
            filter.changeFilter(filter.filterType.next())
        }
    }
    
//    private func startLikeAnimation(){
//        let likeImageView = UIImageView(frame: likeImageViewRect)
//        likeImageView.backgroundColor = UIColor.clear
//        likeImageView.contentMode = .scaleAspectFit
//        likeImageView.image = likeImage
//        likeImageView.alpha = 1.0
//        self.view.addSubview(likeImageView)
//        UIView.animate(withDuration: 0.5, animations: {
//            likeImageView.alpha = 0.0
//        }) { (reuslt) in
//            likeImageView.removeFromSuperview()
//        }
//    }

    
    
    
    
    
    private func sendCandidate(iceCandidate: RTCIceCandidate){
        // let candidate = Candidate.init(sdp: iceCandidate.sdp, sdpMLineIndex: iceCandidate.sdpMLineIndex, sdpMid: iceCandidate.sdpMid!, name: "nomiuser")
        
        
        let candidate = CandidateNew.init(candidate: iceCandidate.sdp, sdpMLineIndex: iceCandidate.sdpMLineIndex, sdpMid: iceCandidate.sdpMid!)
        
        
        
        
        let signalingMessage = sendUserCandidate.init(candidate: candidate, type: "candidate" , name: "923072803568")
        
        
        
        
        
        do {
            let data = try JSONEncoder().encode(signalingMessage)
            let message = String(data: data, encoding: String.Encoding.utf8)!
            print("signalingMessagecandidate",message )
            
            if service?.isConnected ?? false{
                service?.write(string: message)
            }
        }catch{
            print(error)
        }
    }
    
    
    
    @IBAction func callEnd(_ sender: Any) {
        if webRTCClient.isConnected {
            
            
            
            webRTCClient.disconnect()
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func loudSpeaker(_ sender: Any) {
        
        //        self.registerlocal()
    }
    
    @IBAction func videoOnOff(_ sender: Any) {
        CallUser()
    }
    
    @IBAction func micOnOff(_ sender: Any) {
       
        
    }
    
    
    
    @IBAction func acceptCall(_ sender: Any) {
        print("accept Call")
         answerCall()
    }
    
    @IBAction func disconnectCall(_ sender: Any) {
        print("dont accept Call")
    }
    
    
    
    
    
}

// MARK: - WebSocket Delegate
extension CallViewController {
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("-- websocket did connect --")
        wsStatusLabel.text = wsStatusMessageBase + "connected"
        wsStatusLabel.textColor = .green
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("-- websocket did disconnect --")
        wsStatusLabel.text = wsStatusMessageBase + "disconnected"
        wsStatusLabel.textColor = .red
    }
    
    
    
    
    func websocketDidConnect(ws: WebSocket) {
        print("websocket is connected")
    }
    
    func websocketDidDisconnect(ws: WebSocket, error: NSError?) {
        print("websocket is disconnected: \(error?.localizedDescription)")
    }
    
    
    
    
    func websocketDidReceiveMessage(ws: WebSocket, text: String) {
        print("Received text: \(text)")
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
        
        
        
        // print("Received text server: \(text)")
        
        //       let dict = convertToDictionary(text: text)
        
        let text = CustomSocket.instance.text
        let dict  = CustomSocket.instance.diction
        
        
        var sdp = ""
        print("CallVCwebsocketDidReceiveMessage Call VC",dict ?? {})
        
        
        
        if let answer = dict["answer"] as? [String: Any] {
            
            if let sdpp = answer["sdp"] as? String {
                
                
                
                sdp = sdpp
                
            }
        }
        if let yield = dict["offer"] as? [String: Any] {
            
            if let sdpp = yield["sdp"] as? String {
                
                
                
                sdp = sdpp
                
            }
        }
        
        if let type = dict["type"] as? String {
            if type == "offer" {
                
                webRTCClient.receiveOffer(offerSDP: RTCSessionDescription(type: .offer, sdp: sdp), onCreateAnswer: {(answerSDP: RTCSessionDescription) -> Void in
                    
//                    self.sendSDP(sessionDescription: answerSDP)
                })
            }else if type == "answer" {
                
                print("Received text answer: \(sdp)")
                
                webRTCClient.receiveAnswer(answerSDP: RTCSessionDescription(type: .answer, sdp: sdp))
            }
                
            else if type == "candidate" {
                
                do{
                    let ssignalingMessage = try JSONDecoder().decode(receiveUserCandidate.self, from: text.data(using: .utf8)!)
                    
                    let candidate = ssignalingMessage.candidate
                    
                    print("Received text candidate: \(text)")
                    
                    webRTCClient.receiveCandidate(candidate: RTCIceCandidate(sdp: candidate.candidate, sdpMLineIndex: candidate.sdpMLineIndex, sdpMid: candidate.sdpMid))
                }
                catch{
                    print("erroriscandidate",error)
                }
            }
        }
        
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) { }
}

// MARK: - WebRTCClient Delegate
extension CallViewController {
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

        
    }
    
    func didConnectWebRTC() {
        print("didConnectWebRTC")
        // MARK: Disconnect websocket
        // self.socket.disconnect()
    }
    
    func didDisconnectWebRTC() {
        print("didDisconnectWebRTC")
    }
    
    func didOpenDataChannel() {
        print("did open data channel")
    }
    
    func didReceiveData(data: Data) {
        print("didReceiveData")
    }
    
    func didReceiveMessage(message: String) {
        self.webRTCMessageLabel.text = message
        
        print("webRTCMessageLabel", message)
        
    }
}

// MARK: - CameraSessionDelegate
extension CallViewController {
    func didOutput(_ sampleBuffer: CMSampleBuffer) {
        if self.useCustomCapturer {
            if let cvpixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer){
                
                if let buffer = self.cameraFilter?.apply(cvpixelBuffer){
                    self.webRTCClient.captureCurrentFrame(sampleBuffer: buffer)
                }
                    
                else{
                    print("no applied image")
                }
            }
                
            else{
                print("no pixelbuffer")
            }
            //            self.webRTCClient.captureCurrentFrame(sampleBuffer: buffer)
        }
    }
}




//
//  ViewController.swift
//
//  Convex Vchat
//
//  Created by 1234 on 6/10/20.
//  Copyright © 2020 n0. All rights reserved.
//

//import UIKit
//import Starscream
// import UIKit
//import WebRTC
//import ContactsUI
//
//
//class CallViewController: UIViewController, WebSocketDelegate, WebRTCClientDelegate, CameraSessionDelegate {
//
//        @IBOutlet weak var localVideoView: UIView!
//        @IBOutlet weak var remoteVideoViewContainter: UIView!
//        @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
//        @IBOutlet weak var endCall: UIButton!
//        @IBOutlet weak var bottomPlate: UIView!
//
//
//
//    enum messageType {
//        case greet
//        case introduce
//
//        func text() -> String {
//            switch self {
//            case .greet:
//                return "Hello!"
//            case .introduce:
//                return "I'm " + UIDevice.modelName
//            }
//        }
//    }
//
//    //MARK: - Properties
//    var webRTCClient: WebRTCClient!
//    var socket: WebSocket!
//    var tryToConnectWebSocket: Timer!
//    var cameraSession: CameraSession?
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
//    //MARK: - ViewController Override Methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        #if targetEnvironment(simulator)
//        // simulator does not have camera
//        self.useCustomCapturer = false
//        #endif
//
//        webRTCClient = WebRTCClient()
//        webRTCClient.delegate = self
//        webRTCClient.setup(videoTrack: true, audioTrack: true, dataChannel: true, customFrameCapturer: useCustomCapturer)
//
//        if useCustomCapturer {
//            print("--- use custom capturer ---")
//            self.cameraSession = CameraSession()
//            self.cameraSession?.delegate = self
//            self.cameraSession?.setupSession()
//
//            self.cameraFilter = CameraFilter()
//        }
//
//    //  //  socket = WebSocket(url: URL(string: "ws://" + ipAddress + ":8080/")!)
//
//        socket = WebSocket(url: URL(string: socketUrl)!)
//
//        socket.delegate = self
//
//
////        socket.onText = { (text: String) in
////            print("got some text: \(text)")
////        }
////        //websocketDidReceiveData
////        socket.onData = { (data: Data) in
////             print("got some data: \(data.count)")
////        }
//
//
//        tryToConnectWebSocket = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
//            if self.webRTCClient.isConnected || self.socket.isConnected {
//                return
//            }
//
//
//
//
//
//            self.socket.connect()
//
//
//
//
//
//
//
//         //   socket.emit("updateLocation",  data!)
//
//
//        })
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        self.setupUI()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    // MARK: - UI
//    private func setupUI(){
//        let remoteVideoViewContainter = UIView(frame: CGRect(x: 0, y: 0, width: ScreenSizeUtil.width(), height: ScreenSizeUtil.height()*0.7))
//        remoteVideoViewContainter.backgroundColor = .gray
//        self.view.addSubview(remoteVideoViewContainter)
//
//        let remoteVideoView = webRTCClient.remoteVideoView()
//        webRTCClient.setupRemoteViewFrame(frame: CGRect(x: 0, y: 0, width: ScreenSizeUtil.width()*0.7, height: ScreenSizeUtil.height()*0.7))
//        remoteVideoView.center = remoteVideoViewContainter.center
//        remoteVideoViewContainter.addSubview(remoteVideoView)
//
//        let localVideoView = webRTCClient.localVideoView()
//        webRTCClient.setupLocalViewFrame(frame: CGRect(x: 0, y: 0, width: ScreenSizeUtil.width()/3, height: ScreenSizeUtil.height()/3))
//        localVideoView.center.y = self.view.center.y
//        localVideoView.subviews.last?.isUserInteractionEnabled = true
//        self.view.addSubview(localVideoView)
//
//        let localVideoViewButton = UIButton(frame: CGRect(x: 0, y: 0, width: localVideoView.frame.width, height: localVideoView.frame.height))
//        localVideoViewButton.backgroundColor = UIColor.clear
//        localVideoViewButton.addTarget(self, action: #selector(self.localVideoViewTapped(_:)), for: .touchUpInside)
//        localVideoView.addSubview(localVideoViewButton)
//
//        let likeButton = UIButton(frame: CGRect(x: remoteVideoViewContainter.right - 50, y: remoteVideoViewContainter.bottom - 50, width: 40, height: 40))
//        likeButton.backgroundColor = UIColor.clear
//        likeButton.addTarget(self, action: #selector(self.likeButtonTapped(_:)), for: .touchUpInside)
//        self.view.addSubview(likeButton)
//        likeButton.setImage(UIImage(named: "like_border.png"), for: .normal)
//
//        likeImage = UIImage(named: "like_filled.png")
//        likeImageViewRect = CGRect(x: remoteVideoViewContainter.right - 70, y: likeButton.top - 70, width: 60, height: 60)
//
//        let messageButton = UIButton(frame: CGRect(x: likeButton.left - 220, y: remoteVideoViewContainter.bottom - 50, width: 210, height: 40))
//        messageButton.setBackgroundImage(UIColor.green.rectImage(width: messageButton.frame.width, height: messageButton.frame.height), for: .normal)
//        messageButton.addTarget(self, action: #selector(self.sendMessageButtonTapped(_:)), for: .touchUpInside)
//        messageButton.titleLabel?.adjustsFontSizeToFitWidth = true
//        messageButton.setTitle(messageType.greet.text(), for: .normal)
//        messageButton.layer.cornerRadius = 20
//        messageButton.layer.masksToBounds = true
//        self.view.addSubview(messageButton)
//
//        wsStatusLabel = UILabel(frame: CGRect(x: 0, y: remoteVideoViewContainter.bottom, width: ScreenSizeUtil.width(), height: 30))
//        wsStatusLabel.textAlignment = .center
//        self.view.addSubview(wsStatusLabel)
//        webRTCStatusLabel = UILabel(frame: CGRect(x: 0, y: wsStatusLabel.bottom, width: ScreenSizeUtil.width(), height: 30))
//        webRTCStatusLabel.textAlignment = .center
//        webRTCStatusLabel.text = webRTCStatusMesasgeBase + "initialized"
//        self.view.addSubview(webRTCStatusLabel)
//        webRTCMessageLabel = UILabel(frame: CGRect(x: 0, y: webRTCStatusLabel.bottom, width: ScreenSizeUtil.width(), height: 30))
//        webRTCMessageLabel.textAlignment = .center
//        self.view.addSubview(webRTCMessageLabel)
//
//        let buttonWidth = ScreenSizeUtil.width()*0.4
//        let buttonHeight: CGFloat = 60
//        let buttonRadius: CGFloat = 30
//        let callButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight))
//        callButton.setBackgroundImage(UIColor.blue.rectImage(width: callButton.frame.width, height: callButton.frame.height), for: .normal)
//        callButton.layer.cornerRadius = buttonRadius
//        callButton.layer.masksToBounds = true
//        callButton.center.x = ScreenSizeUtil.width()/4
//        callButton.center.y = webRTCStatusLabel.bottom + (ScreenSizeUtil.height() - webRTCStatusLabel.bottom)/2
//        callButton.setTitle("Call", for: .normal)
//        callButton.titleLabel?.font = UIFont.systemFont(ofSize: 23)
//        callButton.addTarget(self, action: #selector(self.callButtonTapped(_:)), for: .touchUpInside)
//        self.view.addSubview(callButton)
//
//        let hangupButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight))
//        hangupButton.setBackgroundImage(UIColor.red.rectImage(width: hangupButton.frame.width, height: hangupButton.frame.height), for: .normal)
//        hangupButton.layer.cornerRadius = buttonRadius
//        hangupButton.layer.masksToBounds = true
//        hangupButton.center.x = ScreenSizeUtil.width()/4 * 3
//        hangupButton.center.y = callButton.center.y
//        hangupButton.setTitle("hang up" , for: .normal)
//        hangupButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
//        hangupButton.addTarget(self, action: #selector(self.hangupButtonTapped(_:)), for: .touchUpInside)
//        self.view.addSubview(hangupButton)
//    }
//
//    // MARK: - UI Events
//    @objc func callButtonTapped(_ sender: UIButton){
//        if !webRTCClient.isConnected {
//            webRTCClient.connect(onSuccess: { (offerSDP: RTCSessionDescription) -> Void in
//
//                self.sendSDP(sessionDescription: offerSDP)
//
//            })
//        }
//    }
//
//    @objc func hangupButtonTapped(_ sender: UIButton){
//        if webRTCClient.isConnected {
//            webRTCClient.disconnect()
//        }
//    }
//
//    @objc func sendMessageButtonTapped(_ sender: UIButton){
//        webRTCClient.sendMessge(message: (sender.titleLabel?.text!)!)
//        if sender.titleLabel?.text == messageType.greet.text() {
//            sender.setTitle(messageType.introduce.text(), for: .normal)
//        }else if sender.titleLabel?.text == messageType.introduce.text() {
//            sender.setTitle(messageType.greet.text(), for: .normal)
//        }
//    }
//
//    @objc func likeButtonTapped(_ sender: UIButton){
//
//
//        let datafield : [String:Any] = ["type":"login","name": "923316519503"]
//
//
//                          //  let data = try? JSONSerialization.data(withJSONObject: datafield)
//                            var error : NSError?
//                            let jsonData = try! JSONSerialization.data(withJSONObject: datafield, options: JSONSerialization.WritingOptions.prettyPrinted)
//                            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
//
//                            print(jsonString)
//
//                  self.socket.write(string: jsonString)
//
//
//
////        let data = likeStr.data(using: String.Encoding.utf8)
////        webRTCClient.sendData(data: data!)
////        self.cameraFilter?.changeFilter((cameraFilter?.filterType.next())!)
//    }
//
//    @objc func localVideoViewTapped(_ sender: UITapGestureRecognizer) {
//        if let filter = self.cameraFilter {
//            filter.changeFilter(filter.filterType.next())
//        }
//    }
//
//
//        @IBAction func loudSpeaker(_ sender: Any) {
//
//    //        self.registerlocal()
//        }
//
//        @IBAction func videoOnOff(_ sender: Any) {
////            CallUser()
//        }
//
//        @IBAction func micOnOff(_ sender: Any) {
////            receivingCall()
//
//        }
//
//
//    private func startLikeAnimation(){
//        let likeImageView = UIImageView(frame: likeImageViewRect)
//        likeImageView.backgroundColor = UIColor.clear
//        likeImageView.contentMode = .scaleAspectFit
//        likeImageView.image = likeImage
//        likeImageView.alpha = 1.0
//        self.view.addSubview(likeImageView)
//        UIView.animate(withDuration: 0.5, animations: {
//            likeImageView.alpha = 0.0
//        }) { (reuslt) in
//            likeImageView.removeFromSuperview()
//        }
//    }
//
//    // MARK: - WebRTC Signaling
//    private func sendSDP(sessionDescription: RTCSessionDescription){
//        var type = ""
//        if sessionDescription.type == .offer {
//            type = "offer"
//
//
//        }else if sessionDescription.type == .answer {
//            type = "answer"
//
//        }
//
//      //  sdk observer
//
//        let sdp = SDP.init(sdp: sessionDescription.sdp)
//        let useroffer = offer.init(sdp: sessionDescription.sdp , type: type)
//
//        let signalingMessage = SignalingMessagee.init(type: type, name: "923072803568", answer: useroffer, candidate: nil)
//        do {
//            let data = try JSONEncoder().encode(signalingMessage)
//            let message = String(data: data, encoding: String.Encoding.utf8)!
//
//             print("sdpsdpsdp",message)
//
//            if self.socket.isConnected {
//                self.socket.write(string: message)
//            }
//        }catch{
//            print(error)
//        }
//    }
//
//    private func sendCandidate(iceCandidate: RTCIceCandidate){
//       // let candidate = Candidate.init(sdp: iceCandidate.sdp, sdpMLineIndex: iceCandidate.sdpMLineIndex, sdpMid: iceCandidate.sdpMid!, name: "nomiuser")
//
//
//        let candidate = CandidateNew.init(candidate: iceCandidate.sdp, sdpMLineIndex: iceCandidate.sdpMLineIndex, sdpMid: iceCandidate.sdpMid!)
//
//
//
//
//        let signalingMessage = sendUserCandidate.init(candidate: candidate, type: "candidate" , name: "923072803568")
//
//
//
//
//
//        do {
//            let data = try JSONEncoder().encode(signalingMessage)
//            let message = String(data: data, encoding: String.Encoding.utf8)!
//            print("signalingMessagecandidate",message )
//
//            if self.socket.isConnected {
//                self.socket.write(string: message)
//
//            }
//        }catch{
//            print(error)
//        }
//    }
//
//}
//
//// MARK: - WebSocket Delegate
//extension CallViewController {
//
//    func websocketDidConnect(socket: WebSocketClient) {
//        print("-- websocket did connect --")
//        wsStatusLabel.text = wsStatusMessageBase + "connected"
//        wsStatusLabel.textColor = .green
//    }
//
//    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
//        print("-- websocket did disconnect --")
//        wsStatusLabel.text = wsStatusMessageBase + "disconnected"
//        wsStatusLabel.textColor = .red
//    }
//
//
//
//
//    func websocketDidConnect(ws: WebSocket) {
//        print("websocket is connected")
//    }
//
//    func websocketDidDisconnect(ws: WebSocket, error: NSError?) {
//        print("websocket is disconnected: \(String(describing: error?.localizedDescription))")
//    }
//
//
//
//
//    func websocketDidReceiveMessage(ws: WebSocket, text: String) {
//        print("Received text: \(text)")
//    }
//
//    func websocketDidReceiveData(ws: WebSocket, data: NSData) {
//         print("Received data: \(data.length)")
//    }
//
//    func websocketDidReceivePong(socket: WebSocket) {
//        print("Got pong!")
//    }
//    func convertToDictionary(text: String) -> [String: Any]? {
//        if let data = text.data(using: .utf8) {
//            do {
//                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//        return nil
//    }
//    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
//
//
//      print("Received text server: \(text)")
//
//       let dict = convertToDictionary(text: text)
//       //
//       //
//       //
//
//      var sdp = ""
//
//      print("convertToDictionaryconvertToDictionary",dict ?? {})
//
//         if let answer = dict?["answer"] as? [String: Any] {
//
//         if let sdpp = answer["sdp"] as? String
//
//
//         {
//
//             sdp = sdpp
//
//         }
//
//        }
//
//                if let yield = dict?["offer"] as? [String: Any] {
//
//                    if let sdpp = yield["sdp"] as? String {
//
//
//
//                        sdp = sdpp
//
//                    }
//        //
//        //
//                             }
//
//        if let type = dict?["type"] as? String {
//             if type == "offer" {
//
//                        webRTCClient.receiveOffer(offerSDP: RTCSessionDescription(type: .offer, sdp: sdp), onCreateAnswer: {(answerSDP: RTCSessionDescription) -> Void in
//
//                        self.sendSDP(sessionDescription: answerSDP)
//
//                        })
//                       }else if type == "answer" {
//
//                print("Received text answer: \(sdp)")
//
//                           webRTCClient.receiveAnswer(answerSDP: RTCSessionDescription(type: .answer, sdp: sdp))
//                       }
//
//                       else if type == "candidate" {
//
//                            do{
//                   let ssignalingMessage = try JSONDecoder().decode(receiveUserCandidate.self, from: text.data(using: .utf8)!)
//
//                        let candidate = ssignalingMessage.candidate
//
//                        print("Received text candidate: \(text)")
//
//                                webRTCClient.receiveCandidate(candidate: RTCIceCandidate(sdp: candidate.candidate, sdpMLineIndex: candidate.sdpMLineIndex, sdpMid: candidate.sdpMid))
//                            }
//                            catch{
//                                         print("erroriscandidate",error)
//                                     }
//
//
//
//
//        }
//
//
//
//
//
//
//
//
////        do{
////
////
////            let signalingMessage = try JSONDecoder().decode(SignalingMessagee.self, from: text.data(using: .utf8)!)
////            print("Received text signalingMessage: \(signalingMessage)")
////
////
////
////            if signalingMessage.type == "offer" {
////
////                webRTCClient.receiveOffer(offerSDP: RTCSessionDescription(type: .offer, sdp: sdp), onCreateAnswer: {(answerSDP: RTCSessionDescription) -> Void in
////
////                    self.sendSDP(sessionDescription: answerSDP)
////              })
////            }else if signalingMessage.type == "answer" {
////
////                webRTCClient.receiveAnswer(answerSDP: RTCSessionDescription(type: .answer, sdp: sdp))
////            }
////
////            else if signalingMessage.type == "candidate" {
////                if let candidate = dict?["candidate"] as? [String: Any] {
////
////                    print("Received text candidate: \(candidate)")
////
////                }
////
////
//////                let candidate = Candidate.init(sdp: sessionDescription.sdp , type: type)
////
////
//////                let candidate = SignalingMessagee.candidate!
//////
//////                print("Received text candidate: \(candidate)")
//////
//////                webRTCClient.receiveCandidate(candidate: RTCIceCandidate(sdp: candidate.sdp, sdpMLineIndex: candidate.sdpMLineIndex, sdpMid: candidate.sdpMid))
////            }
////        }catch{
////            print("erroris",error)
//         }
//
//    }
//
//    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
//
//
//    }
//}
//
//// MARK: - WebRTCClient Delegate
//extension CallViewController {
//    func didGenerateCandidate(iceCandidate: RTCIceCandidate) {
//        self.sendCandidate(iceCandidate: iceCandidate)
//    }
//
//    func didIceConnectionStateChanged(iceConnectionState: RTCIceConnectionState) {
//        var state = ""
//
//        switch iceConnectionState {
//        case .checking:
//            state = "checking..."
//        case .closed:
//            state = "closed"
//        case .completed:
//            state = "completed"
//        case .connected:
//            state = "connected"
//        case .count:
//            state = "count..."
//        case .disconnected:
//            state = "disconnected"
//        case .failed:
//            state = "failed"
//        case .new:
//            state = "new..."
//        }
//        self.webRTCStatusLabel.text = self.webRTCStatusMesasgeBase + state
//    }
//
//    func didConnectWebRTC() {
//        self.webRTCStatusLabel.textColor = .green
//        // MARK: Disconnect websocket
//       // self.socket.disconnect()
//    }
//
//    func didDisconnectWebRTC() {
//        self.webRTCStatusLabel.textColor = .red
//    }
//
//    func didOpenDataChannel() {
//        print("did open data channel")
//    }
//
//    func didReceiveData(data: Data) {
//        if data == likeStr.data(using: String.Encoding.utf8) {
//            self.startLikeAnimation()
//        }
//    }
//
//    func didReceiveMessage(message: String) {
//        self.webRTCMessageLabel.text = message
//    }
//}
//
//// MARK: - CameraSessionDelegate
//extension CallViewController {
//    func didOutput(_ sampleBuffer: CMSampleBuffer) {
//        if self.useCustomCapturer {
//            if let cvpixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer){
//
//            if let buffer = self.cameraFilter?.apply(cvpixelBuffer){
//                    self.webRTCClient.captureCurrentFrame(sampleBuffer: buffer)
//                }
//
//            else{
//                    print("no applied image")
//                }
//            }
//
//            else{
//                print("no pixelbuffer")
//            }
//            //            self.webRTCClient.captureCurrentFrame(sampleBuffer: buffer)
//        }
//    }
//}
