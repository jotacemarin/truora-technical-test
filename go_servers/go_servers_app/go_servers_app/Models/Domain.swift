import Foundation
import EVReflection

class Domain: EVObject {
    var ID: Int64? = 0
    var servers: [Server]? = []
    var serverChanged: Bool? = false
    var sslGrade: String? = ""
    var previusSslGrade: String? = ""
    var logo: String? = ""
    var title: String? = ""
    var isDown: Bool? = false
}
