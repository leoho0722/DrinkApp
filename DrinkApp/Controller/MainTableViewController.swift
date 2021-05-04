import UIKit
import RealmSwift

class MainTableViewController: UITableViewController {

    var productIndexPathRow: Int = 0
    var productPrimaryKey: String? = nil
    var seriesSection: Int = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - TableView Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        
        let realm = try! Realm()
        switch section {
        case 0:
            let ldola = realm.objects(LeftDrinkOLa.self)
            if (ldola.count > 0) { return ldola.count }
        case 1:
            let dhmc = realm.objects(DrinkHugeMilkCover.self)
            if (dhmc.count > 0) { return dhmc.count }
        case 2:
            let dbbola = realm.objects(DrinkBBOLa.self)
            if (dbbola.count > 0) { return dbbola.count }
        case 3:
            let dnt = realm.objects(DrinkNativeTea.self)
            if (dnt.count > 0) { return dnt.count }
        case 4:
            let bl = realm.objects(BrandLimit.self)
            if (bl.count > 0) { return bl.count }
        case 5:
            let dm = realm.objects(DrinkMilk.self)
            if (dm.count > 0) { return dm.count }
        case 6:
            let dh = realm.objects(DrinkHot.self)
            if (dh.count > 0) { return dh.count }
        case 7:
            let cf = realm.objects(CreatorFeat.self)
            if (cf.count > 0) { return cf.count }
        default:
            return 0
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! MainTableViewCell
        let realm = try! Realm()
        switch indexPath.section {
        case 0:
            let ldola = realm.objects(LeftDrinkOLa.self)
            if (ldola.count > 0) {
                cell.textLabel?.text = ldola[indexPath.row].name
                cell.drinkSwitch.isOn = ldola[indexPath.row].isDrink
            }
        case 1:
            let dhmc = realm.objects(DrinkHugeMilkCover.self)
            if (dhmc.count > 0) {
                cell.textLabel?.text = dhmc[indexPath.row].name
                cell.drinkSwitch.isOn = dhmc[indexPath.row].isDrink
            }
        case 2:
            let dbbola = realm.objects(DrinkBBOLa.self)
            if (dbbola.count > 0) {
                cell.textLabel?.text = dbbola[indexPath.row].name
                cell.drinkSwitch.isOn = dbbola[indexPath.row].isDrink
            }
        case 3:
            let dnt = realm.objects(DrinkNativeTea.self)
            if (dnt.count > 0) {
                cell.textLabel?.text = dnt[indexPath.row].name
                cell.drinkSwitch.isOn = dnt[indexPath.row].isDrink
            }
        case 4:
            let bl = realm.objects(BrandLimit.self)
            if (bl.count > 0) {
                cell.textLabel?.text = bl[indexPath.row].name
                cell.drinkSwitch.isOn = bl[indexPath.row].isDrink
            }
        case 5:
            let dm = realm.objects(DrinkMilk.self)
            if (dm.count > 0) {
                cell.textLabel?.text = dm[indexPath.row].name
                cell.drinkSwitch.isOn = dm[indexPath.row].isDrink
            }
        case 6:
            let dh = realm.objects(DrinkHot.self)
            if (dh.count > 0) {
                cell.textLabel?.text = dh[indexPath.row].name
                cell.drinkSwitch.isOn = dh[indexPath.row].isDrink
            }
        case 7:
            let cf = realm.objects(CreatorFeat.self)
            if (cf.count > 0) {
                cell.textLabel?.text = cf[indexPath.row].name
                cell.drinkSwitch.isOn = cf[indexPath.row].isDrink
            }
        default:
            self.alert(message: "目前無資料！")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "刪除") { (action, sourceView, completeHandler) in
            self.productIndexPathRow = indexPath.row
            self.seriesSection = indexPath.section
            DispatchQueue.main.async {
                self.getProductPrimaryKey()
                self.deleteProductFromRealm()
            }
            completeHandler(true)
        }
        let trailingSwipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return trailingSwipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "編輯") { (action, sourceView, completeHandler) in
            self.productIndexPathRow = indexPath.row
            self.seriesSection = indexPath.section
            DispatchQueue.main.async {
                self.getProductPrimaryKey()
                
            }
            completeHandler(true)
        }
        editAction.backgroundColor = UIColor(red: 0.0/255.0, green: 127.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        let leadingSwipeConfiguration = UISwipeActionsConfiguration(actions: [editAction])
        return leadingSwipeConfiguration
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "躺著喝歐蕾"
        } else if (section == 1) {
            return "爽爽喝厚奶蓋"
        } else if (section == 2) {
            return "好好喝珍珠歐蕾"
        } else if (section == 3) {
            return "簡單喝原茶"
        } else if (section == 4) {
            return "品牌限定"
        } else if (section == 5) {
            return "白白喝好農鮮奶"
        } else if (section == 6) {
            return "暖暖喝熱飲"
        } else if (section == 7) {
            return "創作者聯名"
        }
        return ""
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - 其他 Function
    
    @IBAction func refreshTableView(_ sender: UIButton) {
        self.tableView.reloadData()
        self.alert(message: "品項已更新完畢！")
    }
    
    //取得該產品的 Primary Key
    func getProductPrimaryKey() {
        let realm = try! Realm()
        switch seriesSection {
        case 0:
            let id = realm.objects(LeftDrinkOLa.self)
            if (id.count > 0) { self.productPrimaryKey = id[self.productIndexPathRow].id }
        case 1:
            let id = realm.objects(DrinkHugeMilkCover.self)
            if (id.count > 0) { self.productPrimaryKey = id[self.productIndexPathRow].id }
        case 2:
            let id = realm.objects(DrinkBBOLa.self)
            if (id.count > 0) { self.productPrimaryKey = id[self.productIndexPathRow].id }
        case 3:
            let id = realm.objects(DrinkNativeTea.self)
            if (id.count > 0) { self.productPrimaryKey = id[self.productIndexPathRow].id }
        case 4:
            let id = realm.objects(BrandLimit.self)
            if (id.count > 0) { self.productPrimaryKey = id[self.productIndexPathRow].id }
        case 5:
            let id = realm.objects(DrinkMilk.self)
            if (id.count > 0) { self.productPrimaryKey = id[self.productIndexPathRow].id }
        case 6:
            let id = realm.objects(DrinkHot.self)
            if (id.count > 0) { self.productPrimaryKey = id[self.productIndexPathRow].id }
        case 7:
            let id = realm.objects(CreatorFeat.self)
            if (id.count > 0) { self.productPrimaryKey = id[self.productIndexPathRow].id }
        default:
            self.alert(message: "無法取得 Primary Key！")
        }
    }
    
    func alert(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "關閉", style: .default, handler: nil)
        alertController.addAction(closeAction)
        present(alertController,animated: true)
    }
    
    func deleteProductFromRealm() {
        switch seriesSection {
        case 0: self.delFromLeftDrinkOLa()
        case 1: self.delFromDrinkHugeMilkCover()
        case 2: self.delFromDrinkBBOLa()
        case 3: self.delFromDrinkNativeTea()
        case 4: self.delFromBrandLimit()
        case 5: self.delFromDrinkMilk()
        case 6: self.delFromDrinkHot()
        case 7: self.delFromCreatorFeat()
        default: self.alert(message: "產品刪除失敗！")
        }
    }
    
    func delFromLeftDrinkOLa() {
        let realm = try! Realm()
        let deleteMessage = realm.objects(LeftDrinkOLa.self).filter("id = '\(self.productPrimaryKey!)'").first
        try! realm.write {
            realm.delete(deleteMessage!)
        }
    }
    
    func delFromDrinkHugeMilkCover() {
        let realm = try! Realm()
        let deleteMessage = realm.objects(DrinkHugeMilkCover.self).filter("id = '\(self.productPrimaryKey!)'").first
        try! realm.write {
            realm.delete(deleteMessage!)
        }
    }
    
    func delFromDrinkBBOLa() {
        let realm = try! Realm()
        let deleteMessage = realm.objects(DrinkBBOLa.self).filter("id = '\(self.productPrimaryKey!)'").first
        try! realm.write {
            realm.delete(deleteMessage!)
        }
    }
    
    func delFromDrinkNativeTea() {
        let realm = try! Realm()
        let deleteMessage = realm.objects(DrinkNativeTea.self).filter("id = '\(self.productPrimaryKey!)'").first
        try! realm.write {
            realm.delete(deleteMessage!)
        }
    }
    
    func delFromBrandLimit() {
        let realm = try! Realm()
        let deleteMessage = realm.objects(BrandLimit.self).filter("id = '\(self.productPrimaryKey!)'").first
        try! realm.write {
            realm.delete(deleteMessage!)
        }
    }
    
    func delFromDrinkMilk() {
        let realm = try! Realm()
        let deleteMessage = realm.objects(DrinkMilk.self).filter("id = '\(self.productPrimaryKey!)'").first
        try! realm.write {
            realm.delete(deleteMessage!)
        }
    }
    
    func delFromDrinkHot() {
        let realm = try! Realm()
        let deleteMessage = realm.objects(DrinkHot.self).filter("id = '\(self.productPrimaryKey!)'").first
        try! realm.write {
            realm.delete(deleteMessage!)
        }
    }
    
    func delFromCreatorFeat() {
        let realm = try! Realm()
        let deleteMessage = realm.objects(CreatorFeat.self).filter("id = '\(self.productPrimaryKey!)'").first
        try! realm.write {
            realm.delete(deleteMessage!)
        }
    }
}

/*
 ("躺著喝歐蕾",["日安紅歐蕾 (濃茶)","日安紅歐蕾 (厚奶)","午茉綠歐蕾","四季金萱歐蕾","鐵觀音歐蕾"]),
 ("爽爽喝厚奶蓋",["棉被日安紅","棉被午茉綠","棉被四季金萱","棉被鐵觀音"]),
 ("好好喝珍珠歐蕾",["日安紅珍珠歐蕾 (濃茶)","日安紅珍珠歐蕾 (厚奶)","午茉綠珍珠歐蕾","四季金萱珍珠歐蕾","鐵觀音珍珠歐蕾"]),
 ("簡單喝原茶",["日安紅","午茉綠","四季金萱","鐵觀音","檸檬午茉"]),
 ("品牌限定",["香芋啵啵","黑糖香芋啵啵","全糖女神","蕉個芒果yo","萄跑星球go"]),
 ("白白喝好農鮮奶",["黑糖珍珠好濃鮮奶","嫩仙草好濃鮮奶"]),
 ("暖暖喝熱飲",["厚雪嘿啵焙蕾","脆糖嘿啵烤奶","炭烤焙蕾"]),
 ("創作者聯名",["P597 (ft.韓勾ㄟ金針菇)","法bon烤布蕾 (ft.黃氏兄弟)","日no厚抹茶 (ft.黃氏兄弟)"])
*/
