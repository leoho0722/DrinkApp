import Foundation
import RealmSwift

//品牌限定
class BrandLimit: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var series: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var isDrink: Bool = false
    
    override static func primaryKey() -> String {
        return "id"
    }
}
