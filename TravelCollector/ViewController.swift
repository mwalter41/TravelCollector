//
//  ViewController.swift
//  TravelCollector
//
//  Created by Matt Walter on 9/29/16.
//  Copyright © 2016 Matt Walter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var travel : [Travel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
       travel = try context.fetch(Travel.fetchRequest())
        tableView.reloadData()
        } catch {
            
        }
    
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let travels = travel[indexPath.row]
        cell.textLabel?.text = travels.title
        cell.imageView?.image = UIImage(data: travels.image as! Data)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let travels = travel[indexPath.row]
performSegue(withIdentifier: "travelSegue", sender: travels)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! TravelViewController
        nextVC.travel = sender as? Travel
    }
    
}

