import Foundation
import UIKit

struct DrawerModel {
    let image: UIImage
    let name: String
    let item: String

    static func makeDummy() -> [DrawerModel] {
        return [
            DrawerModel(image: .drawer1, name: "for 데이트", item: "서랍 속 옷 : 6벌"),
            DrawerModel(image: .drawer2, name: "for 집 앞 마실", item: "서랍 속 옷 : 4벌"),
            DrawerModel(image: .drawer3, name: "for 전공", item: "서랍 속 옷 : 5벌"),
            DrawerModel(image: .drawer4, name: "for 교양", item: "서랍 속 옷 : 12벌"),
            DrawerModel(image: .drawer5, name: "for 술자리", item: "서랍 속 옷 : 5벌"),
            DrawerModel(image: .drawer6, name: "for 공식적인 자리", item: "서랍 속 옷 : 5벌")
        ]
    }
}
