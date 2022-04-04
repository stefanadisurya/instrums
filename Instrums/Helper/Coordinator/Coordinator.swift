//
//  Coordinator.swift
//  Instrums
//
//  Created by Stefan Adisurya on 04/04/22.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    
}
