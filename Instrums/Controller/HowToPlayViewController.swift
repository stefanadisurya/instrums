//
//  HowToPlayViewController.swift
//  Instrums
//
//  Created by Stefan Adisurya on 29/04/21.
//

import UIKit
import CoreData

class HowToPlayViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    
    var steps: [Steps]?
    
    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchSteps()
        
        tableView.register(UINib(nibName: "StepCell", bundle: nil), forCellReuseIdentifier: "stepCell")
        tableView.allowsSelection = false
    }
    
    func fetchSteps() {
        do {
            let request = Steps.fetchRequest() as NSFetchRequest<Steps>
            
            self.steps = try context.fetch(request)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepCell", for: indexPath) as! StepCell
        
        let step = self.steps![indexPath.row]
        
        cell.stepLabel.text = "\((step.step)!)"
        cell.stepImage.image = UIImage(named: "\((step.step)!)")
        
        return cell
    }
    
}
