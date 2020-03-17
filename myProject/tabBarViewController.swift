import UIKit

class tabBarViewController: UITabBarController {

    var tabBaritem = UITabBarItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.darkGray], for: .normal)
        tabBaritem = self.tabBar.items![0]
        tabBaritem = self.tabBar.items![1]
    }
    
}
