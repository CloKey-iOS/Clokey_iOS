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
        let name : String
    }

    extension ClosetModel {
        static func getDummyData(for segmentIndex: Int) -> [ClosetModel] {
            switch segmentIndex {
            case 0: // 전체
                return [
                    ClosetModel(image: .top, number: "1", count: "9회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "2", count: "8회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "3", count: "8회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "4", count: "7회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "5", count: "7회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "6", count: "6회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "7", count: "9회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "8", count: "8회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "9", count: "8회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "10", count: "7회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "11", count: "7회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "12", count: "6회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "13", count: "9회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "14", count: "8회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "15", count: "8회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "16", count: "7회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "17", count: "7회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "18", count: "6회", name: "꽈배기 반집업 니트")
                ]
            case 1: // 상의
                return [
                    ClosetModel(image: .top, number: "1", count: "8회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "2", count: "5회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "3", count: "3회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "4", count: "1회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "5", count: "1회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "6", count: "1회", name: "꽈배기 반집업 니트")
                ]
            case 2: // 하의
                return [
                    ClosetModel(image: .top, number: "1", count: "6회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "2", count: "4회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "3", count: "2회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "4", count: "2회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "5", count: "2회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "6", count: "2회", name: "꽈배기 반집업 니트")
                ]
            case 3: // 아우터
                return [
                    ClosetModel(image: .top, number: "1", count: "8회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "2", count: "7회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "3", count: "7회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "4", count: "3회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "5", count: "2회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "6", count: "1회", name: "꽈배기 반집업 니트")
                ]
            case 4: // 기타
                return [
                    ClosetModel(image: .top, number: "1", count: "9회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "2", count: "5회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "3", count: "4회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "4", count: "2회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "5", count: "1회", name: "꽈배기 반집업 니트"),
                    ClosetModel(image: .top, number: "6", count: "1회", name: "꽈배기 반집업 니트")
                ]
            default:
                return []
            }
        }
    }
