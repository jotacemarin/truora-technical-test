import UIKit
import Alamofire
import AlamofireImage

class HistoryController: UITableViewController {
    
    var apiBasePath: String = "http://localhost:4500/api/v1"
    var historyList: [Domain] = [Domain]()
    
    override func viewDidLoad() {
    super.viewDidLoad()
        Alamofire.request("\(apiBasePath)/history").responseString { response in
            if let json = response.result.value {
                self.historyList = [Domain](json: json)
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.historyList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "DomainTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DomainTableViewCell else {
            fatalError("The dequeued cell is not an instance of DomainTableViewCell.")
        }
        let domainRow = historyList[indexPath.row]
        cell.domainTitle.text = ""
        cell.domainTitle.text = domainRow.title!
        Alamofire.request(domainRow.logo!, method: .get).responseImage { imageResponse in
            guard let image = imageResponse.result.value else {
                return
            }
            cell.domainLogo.image = image
        }
        cell.domainInfo.text = ""
        cell.domainInfo.text?.append("Ssl Grade: \(domainRow.sslGrade!)\n")
        if domainRow.isDown! {
            cell.domainInfo.text?.append("Active: No\n")
        } else {
            cell.domainInfo.text?.append("Active: Yes\n")
        }
        if domainRow.serverChanged! {
            cell.domainInfo.text?.append("Server Changed: Yes\n")
        } else {
            cell.domainInfo.text?.append("Server Changed: No\n")
        }
        cell.domainInfo.text?.append("Previus Ssl Grade: \(domainRow.previusSslGrade!)\n")
        print(cell.domainInfo.text!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DomainDetailController") as? DomainDetailController
        vc?.domain = historyList[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
