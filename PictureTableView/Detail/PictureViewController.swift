
import UIKit

class PictureViewController: UIViewController {
    
    var picture: Picture?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var urlTF: UITextField!
    
    @IBAction func goBrowser(_ sender: UIButton) {
        if let url = URL(string: (picture?.url)!) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = picture?.image
        urlTF.text = picture?.url
        
        self.urlTF.delegate = self
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }

}

extension PictureViewController: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == urlTF {
            
            UIPasteboard.general.string = picture?.url
            self.MessageAlert(messageText: "Ссылка скопирована", controller: self)
        }
        
        return false
    }
    
    func MessageAlert(messageText: String, controller: UIViewController) {
        let alert = UIAlertController(title: "Уведомление", message: messageText, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Продолжить", style: UIAlertAction.Style.default, handler: nil))
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    
}
