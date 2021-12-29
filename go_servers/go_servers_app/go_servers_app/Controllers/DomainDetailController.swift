import UIKit
import Alamofire
import AlamofireImage

class DomainDetailController: UIViewController {

    var domain: Domain = Domain()
    @IBOutlet weak var domainTitleLbl: UILabel!
    @IBOutlet weak var domainLogoImg: UIImageView!
    @IBOutlet weak var domainInfoTxt: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(self.domain.logo!, method: .get).responseImage { imageResponse in
            guard let image = imageResponse.result.value else {
                return
            }
            self.domainLogoImg.image = image
        }
        self.domainTitleLbl.text = self.domain.title
        self.domainInfoTxt.text = ""
        if self.domain.isDown! {
            self.domainInfoTxt.text?.append("Active: No\n")
        } else {
            self.domainInfoTxt.text?.append("Active: Yes\n")
        }
        self.domainInfoTxt.text?.append("Ssl Grade: \(self.domain.sslGrade!)\n")
        self.domainInfoTxt.text?.append("Previus Ssl Grade: \(self.domain.previusSslGrade!)\n")
        if self.domain.serverChanged! {
            self.domainInfoTxt.text?.append("Server Changed: Yes\n")
        } else {
            self.domainInfoTxt.text?.append("Server Changed: No\n")
        }
        self.domainInfoTxt.text?.append("\nServers:\n")
        self.domain.servers?.forEach { server in
            self.domainInfoTxt.text?.append("Owner: \(server.owner!)\n")
            self.domainInfoTxt.text?.append("Country: \(server.country!)\n")
            self.domainInfoTxt.text?.append("Address: \(server.address!)\n")
            self.domainInfoTxt.text?.append("Ssl Grade: \(server.sslGrade!)\n")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
}
