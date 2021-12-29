import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var domainLbl: UILabel!
    @IBOutlet weak var domainField: UITextField!
    @IBOutlet weak var domainInfoTxt: UITextView!
    @IBOutlet weak var domainLogoImg: UIImageView!
    @IBOutlet weak var serversInfoTxt: UITextView!
    @IBOutlet weak var historyButton: UIBarButtonItem!
    @IBOutlet weak var findButton: UIButton!
    
    var apiBasePath: String = "http://localhost:4500/api/v1"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.domainField.delegate = self
        self.domainLbl.text = "Check server!"
        Alamofire.request("\(apiBasePath)/gostatus").responseJSON { response in
            switch response.result {
            case .success:
                self.domainLbl.text = "Ready!"
            case .failure(let error):
                self.historyButton.isEnabled = false
                self.findButton.isEnabled = false
                self.domainLbl.text = "Service unaviable!"
                print("ERROR: \(error)")
            }
        }
    }

    @IBAction func findButton(_ sender: UIButton) {
        self.domainLbl.text = "Wait moment please...!"
        self.domainInfoTxt.text = ""
        self.serversInfoTxt.text = ""
        Alamofire.request("\(apiBasePath)/analyze?host=\(self.domainField.text!)").responseString { response in
            if let json = response.result.value {
                let domain = Domain(json: json)
                self.domainLbl.text = "\(self.domainField.text!):"
                self.domainInfoTxt.text = ""
                Alamofire.request(domain.logo!, method: .get).responseImage { imageResponse in
                    guard let image = imageResponse.result.value else {
                        return
                    }
                    self.domainLogoImg.image = image
                }
                self.domainInfoTxt.text.append("Title: \t\t\t\t\(domain.title!)\n")
                if domain.isDown! {
                    self.domainInfoTxt.text.append("Active: \t\t\t\tNo\n")
                } else {
                    self.domainInfoTxt.text.append("Active: \t\t\t\tYes\n")
                }
                self.domainInfoTxt.text.append("Ssl Grade: \t\t\t\(domain.sslGrade!)\n")
                self.domainInfoTxt.text.append("Previus Ssl Grade: \t\(domain.previusSslGrade!)\n")
                if domain.serverChanged! {
                    self.domainInfoTxt.text.append("Server Changed: \tYes\n")
                } else {
                    self.domainInfoTxt.text.append("Server Changed: \t\tNo\n")
                }
                self.serversInfoTxt.text = "Servers:\n\n"
                domain.servers?.forEach { server in
                    self.serversInfoTxt.text.append("Owner: \t\(server.owner!)\n")
                    self.serversInfoTxt.text.append("Countr: \t\(server.country!)\n")
                    self.serversInfoTxt.text.append("Address: \t\(server.address!)\n")
                    self.serversInfoTxt.text.append("Ssl Grade: \t\(server.sslGrade!)\n")
                    self.serversInfoTxt.text.append("\n\n")
                }
                self.domainField.text = ""
            }
        }
    }
}
