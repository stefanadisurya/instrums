//
//  HowToPlayViewController.swift
//  Instrums
//
//  Created by Stefan Adisurya on 29/04/21.
//

import UIKit
import CoreData

class HowToPlayViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    
    var stepName = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepName = StepRepository.generateSteps()
        
        tableView.register(UINib(nibName: "StepCell", bundle: nil), forCellReuseIdentifier: "stepCell")
        tableView.allowsSelection = false
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stepName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepCell", for: indexPath) as! StepCell
        
        cell.stepLabel.text = "\(stepName[indexPath.row])"
        cell.stepImage.image = UIImage(named: "\(stepName[indexPath.row])")
        
        return cell
    }
    
}
