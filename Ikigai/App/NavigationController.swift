//
//  NavigationController.swift
//  Ikigai
//
//  Created by Икигай on 09.06.2022.
//

import UIKit

class NavigationController: UINavigationController {
  override var shouldAutorotate: Bool { false }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    topViewController?.preferredStatusBarStyle ?? .default
  }
  
  init(_ rootVC: UIViewController) {
    super.init(nibName: nil, bundle: nil)
    pushViewController(rootVC, animated: false)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let color = UIColor.blue
    navigationBar.tintColor = color
    navigationBar.prefersLargeTitles = true
    navigationBar.titleTextAttributes = [.foregroundColor: color]
    toolbar.tintColor = color
  }
}
