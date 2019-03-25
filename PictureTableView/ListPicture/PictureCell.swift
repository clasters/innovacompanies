import UIKit

class PictureCell: UITableViewCell {

    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var urlLable: UILabel!
    
    func setPicture(picture: Picture) {
        self.pictureView.image = picture.image
        self.urlLable.text = picture.url   
    }
    
}
