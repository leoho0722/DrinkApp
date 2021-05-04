import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController{

    @IBOutlet var accTF: UITextField!
    @IBOutlet var pwTF: UITextField!
    
    var isAlert: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.IntroAlert(message: "如果尚未註冊過帳號的話，請點擊左側的「註冊」按鈕進行註冊;已經註冊過帳號的話，請點擊右側的「登入」按鈕進行登入")
    }
    
    @IBAction func registerAccount(_ sender: UIButton) {
        if (accTF.text == "") {
            self.alert(message: "請輸入帳號！")
        } else {
            Auth.auth().createUser(withEmail:accTF.text!, password: pwTF.text!) { (user, error) in
                if (error == nil) {
                    self.alert(message: "帳號已成功建立！")
                } else {
                    self.alert(message: "\(String(describing: error!.localizedDescription))")
                }
            }
        }
    }
    
    @IBAction func signInAccount(_ sender: UIButton) {
        if (accTF.text == "" || pwTF.text == "") {
            self.alert(message: "請重新輸入帳號密碼！")
        } else {
            Auth.auth().signIn(withEmail:accTF.text!, password: pwTF.text!) { (user, error) in
                if (error == nil) {
                    self.alert(message: "登入成功！")
                } else {
                    self.alert(message: "\(String(describing: error!.localizedDescription))")
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func IntroAlert(message: String) {
        if (isAlert) { } else {
            let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "關閉", style: .default) { (action) in
                self.isAlert = true
            }
            alertController.addAction(closeAction)
            self.present(alertController, animated: true)
        }
    }
    
    func alert(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "關閉", style: .default, handler: nil)
        alertController.addAction(closeAction)
        self.present(alertController, animated: true)
    }
}
