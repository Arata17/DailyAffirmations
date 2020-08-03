//
//  SavedAffirmationsTableViewController.swift
//  Daily Affirmations
//
//  Created by Мирас on 7/31/20.
//  Copyright © 2020 Мирас. All rights reserved.
//

import UIKit
import CoreData
class SavedAffirmationsTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var savedAffirmation: String? = nil
    var affirmationArray = [Affirmations]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        tableView.register(UINib(nibName: "CustomCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        loadAffirmation()
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return affirmationArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! CustomCellTableViewCell
        
        let affirmation = affirmationArray[indexPath.row]
        cell.labelText.text = affirmation.affirmationText
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
//MARK: - Table View Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //Deleting tableview cells by swiping
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, boolValue) in
            self.context.delete(self.affirmationArray[indexPath.row])
            self.affirmationArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.saveAffirmations()
        }
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeAction
    }
//MARK: - Core Data Manipulation
    func saveAffirmations(){
          do{
              try context.save()
          } catch {
              print("Error saving context \(error)")
          }
      }
    func loadAffirmation(){
        let request: NSFetchRequest<Affirmations> = Affirmations.fetchRequest()
        do{
            affirmationArray = try context.fetch(request)
        } catch {
            print("Error loading affirmations \(error)")
        }
        tableView.reloadData()
    }
    

}
