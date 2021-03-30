import UIKit
import RealmSwift

class AddProductViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var seriesTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var isDrinkSwitch: UISwitch!
    
    var seriesData = ["躺著喝歐蕾","爽爽喝厚奶蓋","好好喝珍珠歐蕾","簡單喝原茶","品牌限定","白白喝好農鮮奶","暖暖喝熱飲","創作者聯名"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let seriesPickerView = UIPickerView()
        seriesPickerView.dataSource = self
        seriesPickerView.delegate = self
        seriesTextField.inputView = seriesPickerView
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return seriesData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return seriesData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        seriesTextField.text = seriesData[row]
    }
    
    @IBAction func addProduct(_ sender: UIButton) {
        if (seriesTextField.text == "" || nameTextField.text == "") {
            self.alert(message: "新增品項失敗，請重新輸入！")
        } else {
            self.addProductToRealm()
            self.alert(message: "新增品項成功！")
        }
    }
    
    // MARK: - 其他 Function
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func alert(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "關閉", style: .default, handler: nil)
        alertController.addAction(closeAction)
        present(alertController,animated: true)
    }
    
    // MARK: - 儲存進 Realm 資料庫
    
    func addProductToRealm() {
        switch seriesTextField.text {
        case "躺著喝歐蕾":
            self.saveToLeftDrinkOLa()
        case "爽爽喝厚奶蓋":
            self.saveToDrinkHugeMilkCover()
        case "好好喝珍珠歐蕾":
            self.saveToDrinkBBOLa()
        case "簡單喝原茶":
            self.saveToDrinkNativeTea()
        case "品牌限定":
            self.saveToBrandLimit()
        case "白白喝好農鮮奶":
            self.saveToDrinkMilk()
        case "暖暖喝熱飲":
            self.saveToDrinkHot()
        case "創作者聯名":
            self.saveToCreatorFeat()
        default:
            self.alert(message: "無此產品系列！")
        }
    }
    
    func saveToLeftDrinkOLa() {
        let realm = try! Realm()
        let ldola = LeftDrinkOLa()
        ldola.series = "躺著喝歐蕾"
        ldola.name = nameTextField.text!
        ldola.isDrink = isDrinkSwitch.isOn
        try! realm.write {
            realm.add(ldola)
        }
        print(realm.configuration.fileURL!)
    }
    
    func saveToDrinkHugeMilkCover() {
        let realm = try! Realm()
        let dhmc = DrinkHugeMilkCover()
        dhmc.series = "爽爽喝厚奶蓋"
        dhmc.name = nameTextField.text!
        dhmc.isDrink = isDrinkSwitch.isOn
        try! realm.write {
            realm.add(dhmc)
        }
        print(realm.configuration.fileURL!)
    }
    
    func saveToDrinkBBOLa() {
        let realm = try! Realm()
        let dbbola = DrinkBBOLa()
        dbbola.series = "好好喝珍珠歐蕾"
        dbbola.name = nameTextField.text!
        dbbola.isDrink = isDrinkSwitch.isOn
        try! realm.write {
            realm.add(dbbola)
        }
        print(realm.configuration.fileURL!)
    }
    
    func saveToDrinkNativeTea() {
        let realm = try! Realm()
        let dnt = DrinkNativeTea()
        dnt.series = "簡單喝原茶"
        dnt.name = nameTextField.text!
        dnt.isDrink = isDrinkSwitch.isOn
        try! realm.write {
            realm.add(dnt)
        }
        print(realm.configuration.fileURL!)
    }
    
    func saveToBrandLimit() {
        let realm = try! Realm()
        let bl = BrandLimit()
        bl.series = "品牌限定"
        bl.name = nameTextField.text!
        bl.isDrink = isDrinkSwitch.isOn
        try! realm.write {
            realm.add(bl)
        }
        print(realm.configuration.fileURL!)
    }
    
    func saveToDrinkMilk() {
        let realm = try! Realm()
        let dm = DrinkMilk()
        dm.series = "白白喝好農鮮奶"
        dm.name = nameTextField.text!
        dm.isDrink = isDrinkSwitch.isOn
        try! realm.write {
            realm.add(dm)
        }
        print(realm.configuration.fileURL!)
    }
    
    func saveToDrinkHot() {
        let realm = try! Realm()
        let dh = DrinkHot()
        dh.series = "暖暖喝熱飲"
        dh.name = nameTextField.text!
        dh.isDrink = isDrinkSwitch.isOn
        try! realm.write {
            realm.add(dh)
        }
        print(realm.configuration.fileURL!)
    }
    
    func saveToCreatorFeat() {
        let realm = try! Realm()
        let cf = CreatorFeat()
        cf.series = "創作者聯名"
        cf.name = nameTextField.text!
        cf.isDrink = isDrinkSwitch.isOn
        try! realm.write {
            realm.add(cf)
        }
        print(realm.configuration.fileURL!)
    }
}
