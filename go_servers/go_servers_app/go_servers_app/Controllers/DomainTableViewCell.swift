import UIKit

class DomainTableViewCell: UITableViewCell {
    @IBOutlet weak var domainLogo: UIImageView!
    @IBOutlet weak var domainTitle: UILabel!
    @IBOutlet weak var domainInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
