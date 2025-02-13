//
//  FolderRequestDTO.swift
//  Clokey
//
//  Created by 한태빈 on 2/13/25.
//

import Foundation


// 폴더 생성
public struct FolderMakeRequestDTO: Codable {
    public let folderName: String
    public let clothIds: [Int64]
}

// 폴더에 옷 추가
public struct FolderAddClothRequestDTO: Codable {
    public let clothIds: [Int64]
}

// 폴더에 옷 제거
public struct FolderDeleteClothRequestDTO: Codable {
    public let clothIds: [Int64]
}

// 폴더 삭제
public struct FolderDeleteRequestDTO: Codable {
    public let folderId: Int64
}

// 폴더 이름 수정
public struct FolderRenameRequestDTO: Codable {
    public let folderName: String
}

