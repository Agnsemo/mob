import UIKit

extension UITableView {

    func registerCellNib<T: UITableViewCell>(withType type: T.Type) {
        let identifier: String = className(fromClass: type)
        
        guard Bundle.main.path(forResource: identifier, ofType: "nib") != nil else {
            print("ERROR! Could not find NIB - \(identifier) in main bundle")
            return
        }
        
        let nib = UINib(nibName: identifier, bundle: Bundle.main)
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        let identifier: String = className(fromClass: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            print("ERROR! Could not dequeue cell with identifier \(identifier) for indexPath \(indexPath) ")
            return nil
        }
        
        return cell
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withType type: T.Type = T.self) -> T? {
        // Concrete class is indicated by parameter:
        // let cell: AaaTableViewCellProtocol = tableView.dequeueReusableCell(withType: AaaTableViewCell.self)
        // If parameter is not used, class is indicated by type of variable the return value is assigned to:
        // let cell: AaaTableViewCell = tableView.dequeueReusableCell()
        
        let identifier: String = className(fromClass: type)
        guard let cell = dequeueReusableCell(withIdentifier: identifier) as? T else {
            print("ERROR! Could not dequeue cell with identifier \(identifier)")
            return nil
        }
        
        return cell
    }
}

func log(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
        let fileName = file.components(separatedBy: "/").last ?? file
        NSLog("[\((fileName as NSString).deletingPathExtension).\(function) \(line) <\((Thread.isMainThread) ? "M" : "B")>]: \(message)")
    #endif
}

func className(fromClass aClass: AnyClass) -> String {
    return String(describing: aClass)
}

