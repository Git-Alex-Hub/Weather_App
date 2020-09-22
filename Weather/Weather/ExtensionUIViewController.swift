import Foundation
import UIKit

extension UIViewController {
    
    func formateCurrentDate (date: TimeInterval) -> String {
        let date = NSDate(timeIntervalSince1970: date)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return (formatter.string(from: date as Date) as NSString) as String
    }
    
    func formateCurrentTimeInterval (date: TimeInterval) -> String {
        let date = NSDate(timeIntervalSince1970: date)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return (formatter.string(from: date as Date) as NSString) as String
    }
}
