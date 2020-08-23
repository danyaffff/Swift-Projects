//
//  MovieViewController.swift
//  App
//
//  Created by Даниил Храповицкий on 22.08.2020.
//

import UIKit
import CoreData

class MovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filmImageView: UIImageView!
    @IBOutlet weak var filmUILabel: UILabel!
    
    var movies = [Movies]()
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Movies> = Movies.fetchRequest()
        
        do {
            movies = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if movies.count == 0 {
            filmImageView.isHidden = false
            filmUILabel.isHidden = false
        } else {
            filmImageView.isHidden = true
            filmUILabel.isHidden = true
        }
    }
    
    @IBAction func addMovieAndGoBack(unwindSegue: UIStoryboardSegue) {}
    
    // MARK: - Methods
    
    func saveMovie(movie: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Movies", in: context)
        let movieObject = NSManagedObject(entity: entity!, insertInto: context) as! Movies
        
        movieObject.name = movie
        
        do {
            try context.save()
            movies.append(movieObject)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateMovie(movie: String, row: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        context.setValue(movie, forKey: "name")
        
        movies[row].name = movie
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue", let destinationVC = segue.destination as? UINavigationController {
            if let targetController = destinationVC.topViewController as? AddTableViewController {
                
                let indexPath = tableView.indexPathForSelectedRow!
                targetController.tempMovieName = movies[indexPath.row].name!
                targetController.selectedRow = indexPath.row
            }
        }
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movies.count == 0 {
            tableView.alwaysBounceVertical = false
            filmImageView.isHidden = false
            filmUILabel.isHidden = false
        } else {
            tableView.alwaysBounceVertical = true
            filmImageView.isHidden = true
            filmUILabel.isHidden = true
        }
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editSegue", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(movies[indexPath.row])
        movies.remove(at: indexPath.row)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
