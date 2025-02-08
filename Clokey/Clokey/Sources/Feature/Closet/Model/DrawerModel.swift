import Foundation
import UIKit

struct DrawerModel {
    /*
    let folderId: Int //Response Data용 (전체 폴더 조회 API)
    let folderName: String //Response Data용 (전체 폴더 생성 API)
    let clothCount: Int //Response Data용 (전체 폴더 조회 API)
    let mainImage: String //Response Data용 (전체 폴더 조회 API)
    let clothIds: [Int] //Response Data용 (폴더에 옷 추가 API)
     */
    let image: UIImage
    let name : String
    let item: String

    static func makeDummy() -> [DrawerModel] {
/*
        return [
            DrawerModel(folderId :0, mainImage: .drawer1, folderName: "for 데이트", item: "서랍 속 옷 : 6벌"),
            DrawerModel(folderId : 1, mainImage: .drawer2, folderName: "for 집 앞 마실", item: "서랍 속 옷 : 4벌"),
            DrawerModel(folderId : 2, mainImage: .drawer3, folderName: "for 전공", item: "서랍 속 옷 : 5벌"),
            DrawerModel(folderId : 3, mainImage: .drawer4, folderName: "for 교양", item: "서랍 속 옷 : 12벌"),
            DrawerModel(folderId : 4, mainImage: .drawer5, folderName: "for 술자리", item: "서랍 속 옷 : 5벌"),
            DrawerModel(folderId : 5, mainImage: .drawer6, folderName: "for 공식적인 자리", item: "서랍 속 옷 : 5벌")
        ]
 */
        return [
            DrawerModel(image: .top, name: "for 데이트", item: "6 벌"),
            DrawerModel(image: .top, name: "for 집 앞 마실", item: "4 벌"),
            DrawerModel(image: .top, name: "for 전공", item: "5 벌"),
            DrawerModel(image: .top, name: "for 교양", item: "6 벌"),
            DrawerModel(image: .top, name: "for 술자리", item: "4 벌"),
            DrawerModel(image: .top, name: "for 공식적인 자리", item: "5 벌")
        ]
    }
}
