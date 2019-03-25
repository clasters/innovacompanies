
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
        
        urlTF.delegate = self
        urlTF.inputView = UIView() 
// TODO  
//        NotificationCenter.default.addObserver(self, selector: #selector(PictureViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(PictureViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
}

extension PictureViewController: UITextFieldDelegate{

    // Запрещает редактировать UITextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    // Скрывает клавиатуру при нажатии вне UITextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
