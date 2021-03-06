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
            self.alert(message: "??????????????????")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "??????") { (action, sourceView, completeHandler) in
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
        let editAction = UIContextualAction(style: .normal, title: "??????") { (action, sourceView, completeHandler) in
            self.productIndexPathRow = indexPath.row
            self.seriesSection = indexPath.section
            DispatchQueue.main.async {
                self.getProductPrimaryKey()
                self.updateData()
            }
            completeHandler(true)
        }
        editAction.backgroundColor = UIColor(red: 0.0/255.0, green: 127.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        let leadingSwipeConfiguration = UISwipeActionsConfiguration(actions: [editAction])
        return leadingSwipeConfiguration
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "???????????????"
        } else if (section == 1) {
            return "??????????????????"
        } else if (section == 2) {
            return "?????????????????????"
        } else if (section == 3) {
            return "???????????????"
        } else if (section == 4) {
            return "????????????"
        } else if (section == 5) {
            return "?????????????????????"
        } else if (section == 6) {
            return "???????????????"
        } else if (section == 7) {
            return "???????????????"
        }
        return ""
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - ?????? Function
    
    @IBAction func refreshTableView(_ sender: UIButton) {
        self.tableView.reloadData()
        self.alert(message: "????????????????????????")
    }
    
    //?????????????????? Primary Key
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
            self.alert(message: "???????????? Primary Key???")
        }
    }
    
    func updateData() {
        if let controller = storyboard?.instantiateViewController(identifier: "AddProductPage") as? AddProductViewController {
            self.present(controller, animated: true)
        }
    }
    
    func alert(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "??????", style: .default, handler: nil)
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
        default: self.alert(message: "?????????????????????")
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
 ("???????????????",["??????????????? (??????)","??????????????? (??????)","???????????????","??????????????????","???????????????"]),
 ("??????????????????",["???????????????","???????????????","??????????????????","???????????????"]),
 ("?????????????????????",["????????????????????? (??????)","????????????????????? (??????)","?????????????????????","????????????????????????","?????????????????????"]),
 ("???????????????",["?????????","?????????","????????????","?????????","????????????"]),
 ("????????????",["????????????","??????????????????","????????????","????????????yo","????????????go"]),
 ("?????????????????????",["????????????????????????","?????????????????????"]),
 ("???????????????",["??????????????????","??????????????????","????????????"]),
 ("???????????????",["P597 (ft.??????????????????)","???bon????????? (ft.????????????)","???no????????? (ft.????????????)"])
*/
