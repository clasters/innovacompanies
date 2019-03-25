import UIKit

class PictureListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate let blocksDispatchQueue = DispatchQueue(label: "com.domain.app.blocks", qos: .utility, attributes: .concurrent)
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage?
    fileprivate var pictures: [Picture] = []
    
    fileprivate var arrayPictureURL = [
    "https://cdn.trinixy.ru/pics3/20080124/podb/6/krasota_01.jpg",
    "https://avatarko.ru/img/kartinka/1/cherep_uzhasy_griby.jpg",
    "http://www.radionetplus.ru/uploads/ssposts/2013-05/1369460621_panda-26.jpg",
    "https://cdn.trinixy.ru/pics3/20080124/podb/6/krasota_02.jpg",
    "https://cdn.trinixy.ru/pics3/20080124/podb/6/krasota_03.jpg",
    "https://cdn.trinixy.ru/pics3/20080124/podb/6/krasota_04.jpg",
    "https://cdn.trinixy.ru/pics3/20080124/podb/6/krasota_06.jpg"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchArrayImage()
        
        DispatchQueue.main.async {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
        
    }
    
    fileprivate func fetchArrayImage(){
        activityIndicator.startAnimating()
        let group = DispatchGroup()
        // Асинхронно получаем данные
        blocksDispatchQueue.async(group: group, flags: .barrier) {
            for url in self.arrayPictureURL{
            //DispatchQueue.concurrentPerform(iterations: self.arrayPictureURL.count) { (index) in
                
                if let imageURL = URL(string: url), let imageData = try? Data(contentsOf: imageURL) {
                    self.pictures.append(Picture(url: url, image: UIImage(data: imageData)!))
                } else {
                    self.pictures.append(Picture(url: "Invalid URL", image: UIImage(named: "default")!))
                  }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        // Ждем окончания загрузки: скрываем индикатор
        group.notify(queue: .main) {
            self.activityIndicator.isHidden = true
        }
        
    }
    
    // Переходим на PictureViewController и передаем данные
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
              let dvc = segue.destination as! PictureViewController
                dvc.picture = self.pictures[indexPath.row]
            }
        }
    }
    
}


extension PictureListController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let picture = pictures[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell") as! PictureCell
        
        cell.setPicture(picture: picture)
        
        return cell
    }
    
}
