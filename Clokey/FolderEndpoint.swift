//
//  FolderEndpoint.swift
//  Clokey
//
//  Created by 한태빈 on 2/13/25.
//

import Foundation
import Moya

// 폴더 생성
public enum FolderEndpoint{
    case folderCheck(folderId: Int, page: Int)
    case folderAll(page: Int)
    case folderMake(data: FolderMakeRequestDTO)
    case folderAddCloth(folderId: Int, data: FolderAddClothRequestDTO)
    case folderDeleteCloth(folderId: Int, data: FolderDeleteClothRequestDTO)
    case folderDelete(folderId: Int, data: FolderDeleteRequestDTO)
    case folderRename(folderId: Int, data: FolderRenameRequestDTO)
}
extension FolderEndpoint: TargetType {
    public var baseURL: URL {
        guard let url = URL(string: API.baseURL) else {
            fatalError("잘못된 URL입니다.")
        }
        return url
    }
    
    // 엔드 포인트 주소
    public var path: String {
        switch self {// page 에 대해 질문
        case .folderCheck(let folderId, _):
            return "/folders/\(folderId)/clothes"
        case .folderAll:
            return "/folders"
        case .folderMake:
            return "/folders"
        case .folderAddCloth(let folderId, _):
            return "/folders/\(folderId)/clothes"
        case .folderDeleteCloth(let folderId, _):
            return "/folders(folderId)/clothes" // POST에 적혀 있는 주소 return
        case .folderDelete(let folderId, _):
            return "/folders/\(folderId)"
        case .folderRename(let folderId, _):
            return "/folders/\(folderId)"
        }
    }
    
    // HTTP 메서드
    public var method: Moya.Method {
        switch self {
        case .folderMake, .folderAddCloth:
            return .post
        case .folderRename:
            return .patch
        case .folderCheck, .folderAll:
            return .get
        case .folderDeleteCloth, .folderDelete:
            return .delete
        }
    }
    //요청 데이터
    public var task: Moya.Task {
        switch self {
        case .folderCheck:
            return .requestPlain
        case .folderAll:
            return .requestPlain
        case .folderMake(let data):
            return .requestJSONEncodable(data)
        case .folderAddCloth(_, let data):
            return .requestJSONEncodable(data)
        case .folderDeleteCloth(_, let data):
            return .requestJSONEncodable(data)
        case .folderDelete(_, let data):
            return .requestJSONEncodable(data)
        case .folderRename(_, let data):
            return .requestJSONEncodable(data)
        }
    }
    
    
    public var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}
