import Foundation
import RealmSwift

//簡單喝原茶
class DrinkNativeTea: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var series: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var isDrink: Bool = false
    
    override static func primaryKey() -> String {
        return "id"
    }
}
