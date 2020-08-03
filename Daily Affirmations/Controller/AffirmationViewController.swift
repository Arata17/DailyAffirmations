//
//  ViewController.swift
//  Daily Affirmations
//
//  Created by Мирас on 7/30/20.
//  Copyright © 2020 Мирас. All rights reserved.
//

import UIKit
import CoreData


class AffirmationViewController: UIViewController{
    @IBOutlet weak var affirmationButton: UIButton!
    @IBOutlet weak var affirmationLabel: UILabel!
    @IBOutlet weak var bookMarkButton: UIButton!
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var affirmationArray = [Affirmations]()
    
    let affirmationData = AffirmationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        affirmationData.delegate = self
        affirmationButton.layer.cornerRadius = 10.0
    }
    
    
    @IBAction func bookMarkButtonPressed(_ sender: UIButton) {
        bookMarkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.bookMarkButton.setImage(UIImage(systemName: "plus"), for: .normal)
        }
        if(affirmationExists(text: affirmationLabel.text!) != -1){
            let index = affirmationExists(text: affirmationLabel.text!)
            context.delete(affirmationArray[index])
            affirmationArray.remove(at: index)
        } else{
            let newAffirmation = Affirmations(context: self.context)
            newAffirmation.affirmationText = affirmationLabel.text!
            affirmationArray.append(newAffirmation)
            saveAffirmations()
        }
    }
    
    @IBAction func affirmationButtonPressed(_ sender: UIButton) {
        affirmationData.getAffirmation()
    }
    
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
    }
    
    func affirmationExists(text: String) -> Int{
        for i in 0..<affirmationArray.count{
            let affirmation = affirmationArray[i]
            if(affirmation.affirmationText == text){
                return i
            }
        }
        return -1
    }
}

//MARK: - Affirmation Manager Delegate
extension AffirmationViewController: AffirmationManagerDelegate{
    func didUpdateAffirmation(_ affirmationManager: AffirmationManager, affirmation: AffirmationModel) {
        DispatchQueue.main.async {
            self.affirmationLabel.text = affirmation.affirmation
        }
    }
    
    
}

