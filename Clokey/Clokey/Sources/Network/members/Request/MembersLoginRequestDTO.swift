//
//  MembersLoginRequestDTO.swift
//  Clokey
//
//  Created by 황상환 on 1/27/25.
//

import Foundation

// 애플 로그인, 카카오 로그인, 약관 동의, 프로필 수정 DTO 모음

// 로그인(카카오/애플)
public struct LoginRequestDTO: Codable {
    public let type: String
    public let accessToken: String?
    public let authorizationCode: String?
//    public let deviceToken: String
}

// 토큰 재발급
public struct ReissueTokenRequestDTO: Codable {
    public let refreshToken: String
}

// 약관동의
public struct AgreementToTermsRequestDTO: Codable {
    public let terms: [Terms]
    
    public struct Terms: Codable {
        public let termId: Int
        public let agreed: Bool
        
    }
}

// 프로필 수정
public struct ProfileUpdateRequestDTO: Codable {
    public let nickname: String
    public let clokeyId: String
    public let bio: String
    public let visibility: String
    
    public var profileImageUrl: Data?
    public var profileBackImageUrl: Data?
    
    enum CodingKeys: String, CodingKey {
        case nickname, clokeyId, bio, visibility
    }
}
