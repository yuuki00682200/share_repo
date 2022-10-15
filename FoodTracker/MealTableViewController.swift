//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by 冨田健介 on 2021/08/07.
//  Copyright © 2021 NeppsStaff. All rights reserved.
//

import UIKit
import OSLog

class MealTableViewController: UITableViewController {
    
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleMeals()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){ super.prepare(for: segue, sender: sender)
        
        switch segue.identifier ?? "" {
        case "AddItem":
            os_log("新しいmealを追加", log: .default, type: .debug)
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? MealDetailViewController else {
                fatalError("意味不明(想定されてない)なsender")
            }
            guard let selectedMealCell = sender as? MealTableViewCell  else {
                fatalError("意味不明(想定されてない)なdestination(送信先)")
            }
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("選択されたcellはTableに表示されていません")
            }
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
        default:
            fatalError("意味不明(想定されてない)なsegueのindentifier; \(String(describing: segue.identifier))")
        }
        
    }

    //9月18日時点: 次は、15ページから
    @IBAction func unwindToMealList(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as?
            MealDetailViewController, let meal = sourceViewController.meal{
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else{
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        
    }
    
    
    //MARK: Private Methods
    private func loadSampleMeals(){
        let photo1 = #imageLiteral(resourceName: "meal1")
        let photo2 = #imageLiteral(resourceName: "meal2")
        let photo3 = #imageLiteral(resourceName: "meal3")
        
        guard let meal1 = Meal(name: "Hamburger", photo: photo1, rating: 4)
        else {
            fatalError("ありえないエラーです")
        }
        
        guard let meal2 = Meal(name: "Sushi Bento", photo: photo2, rating: 5)
        else {
            fatalError("ありえないエラーです")
        }
        
        guard let meal3 = Meal(name: "Grilled Beef", photo: photo3, rating: 3)
        else {
            fatalError("ありえないエラーです")
        }
        
        meals += [meal1,meal2,meal3]
        //
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIndentifier = "MealTableViewCell"
        // Configure the cell...
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("error!")
        }
        
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.RatingControl.rating = meal.rating
        
        return cell
    }
    
    
}







/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 /*
 ))
 /*
 
 */*/*/
