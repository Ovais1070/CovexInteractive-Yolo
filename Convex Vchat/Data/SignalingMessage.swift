//
//  SignalingSDP.swift
//  SimpleWebRTC
//
//  Created by n0 on 2019/01/08.
//  Copyright © 2019 n0. All rights reserved.
//

import Foundation

//struct SignalingSDP: Codable {
//    let type: String
//    let sdp: String
//}
//
//struct SignalingCandidate: Codable {
//    let type: String
//    let candidate: Candidate
//}

struct SignalingMessage: Codable {
    let type: String
    let sessionDescription: SDP?
   let candidate: Candidate?
}


//struct SignalingMessagee: Codable {
//   let type: String
//    let name: String
//
//   let answer: offer
//    let candidate: Candidate?
//
//
//}

//struct offer: Codable {
//    let sdp: String
//    let type: String
//}
struct SDP: Codable {
    let sdp: String
}

//struct Candidate: Codable {
//    let sdp: String
//    let sdpMLineIndex: Int32
//    let sdpMid: String
//    let name: String
//}


struct sendUserCandidate: Codable {
    let candidate: CandidateNew
    let type: String
    let name: String

}
struct receiveUserCandidate: Codable {
    let candidate: CandidateNew
    let type: String
 
}
struct CandidateNew: Codable {
    let candidate: String
    let sdpMLineIndex: Int32
    let sdpMid: String
 }
