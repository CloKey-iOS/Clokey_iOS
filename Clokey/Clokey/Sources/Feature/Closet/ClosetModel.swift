    //
    //  ClosetModel.swift
    //  Clokey
    //
    //  Created by 한태빈 on 1/19/25.

    import Foundation
    import UIKit

    struct ClosetModel{
        let image: UIImage
        let number: String
        let count : String
    }

    extension ClosetModel {
        static func getDummyData(for segmentIndex: Int) -> [ClosetModel] {
            switch segmentIndex {
            case 0: // 전체
                return [
                    ClosetModel(image: .top, number: "1", count: "N회"),
                    ClosetModel(image: .top2, number: "2", count: "N회"),
                    ClosetModel(image: .pants, number: "3", count: "N회"),
                    ClosetModel(image: .outer, number: "4", count: "N회"),
                    ClosetModel(image: .top, number: "5", count: "N회"),
                    ClosetModel(image: .top2, number: "6", count: "N회"),
                    ClosetModel(image: .pants, number: "7", count: "N회"),
                    ClosetModel(image: .outer, number: "8", count: "N회")
                ]
            case 1: // 상의
                return [
                    ClosetModel(image: .top, number: "1", count: "N회"),
                    ClosetModel(image: .top, number: "2", count: "N회"),
                    ClosetModel(image: .top, number: "3", count: "N회"),
                    ClosetModel(image: .top, number: "4", count: "N회"),
                    ClosetModel(image: .top2, number: "5", count: "N회"),
                    ClosetModel(image: .top2, number: "6", count: "N회"),
                    ClosetModel(image: .top2, number: "7", count: "N회"),
                    ClosetModel(image: .top2, number: "8", count: "N회")
                ]
            case 2: // 하의
                return [
                    ClosetModel(image: .pants, number: "1", count: "N회"),
                    ClosetModel(image: .pants, number: "2", count: "N회"),
                    ClosetModel(image: .pants, number: "3", count: "N회"),
                    ClosetModel(image: .pants, number: "4", count: "N회"),
                    ClosetModel(image: .pants, number: "5", count: "N회"),
                    ClosetModel(image: .pants, number: "6", count: "N회"),
                    ClosetModel(image: .pants, number: "7", count: "N회"),
                    ClosetModel(image: .pants, number: "8", count: "N회")
                ]
            case 3: // 아우터
                return [
                    ClosetModel(image: .outer, number: "1", count: "N회"),
                    ClosetModel(image: .outer, number: "2", count: "N회"),
                    ClosetModel(image: .outer, number: "3", count: "N회"),
                    ClosetModel(image: .outer, number: "4", count: "N회"),
                    ClosetModel(image: .outer, number: "5", count: "N회"),
                    ClosetModel(image: .outer, number: "6", count: "N회"),
                    ClosetModel(image: .outer, number: "7", count: "N회"),
                    ClosetModel(image: .outer, number: "8", count: "N회")
                ]
            case 4: // 기타
                return [
                    ClosetModel(image: .outer, number: "1", count: "N회"),
                    ClosetModel(image: .outer, number: "2", count: "N회"),
                    ClosetModel(image: .outer, number: "3", count: "N회"),
                    ClosetModel(image: .outer, number: "4", count: "N회"),
                    ClosetModel(image: .outer, number: "5", count: "N회"),
                    ClosetModel(image: .outer, number: "6", count: "N회"),
                    ClosetModel(image: .outer, number: "7", count: "N회"),
                    ClosetModel(image: .outer, number: "8", count: "N회")
                ]
            default:
                return []
            }
        }
    }
