//
//  AddTableViewController.swift
//  App
//
//  Created by Даниил Храповицкий on 22.08.2020.
//

import UIKit

class AddTableViewController: UITableViewController {
    var tempMovieName = ""
    var selectedRow = -1
    
    @IBOutlet weak var movieNameTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieNameTextField.text = tempMovieName
        
        movieNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        movieNameTextField.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goBack" {
            let destinationVC = segue.destination as! MovieViewController
            
            if tempMovieName == "" {
                destinationVC.saveMovie(movie: movieNameTextField.text!)
            } else {
                destinationVC.updateMovie(movie: movieNameTextField.text!, row: selectedRow)
            }
            destinationVC.tableView.reloadData()
        }
    }
    
    @IBAction func tapCancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - @objc
    
    @objc func textFieldDidChange() {
        if (movieNameTextField.text?.isEmpty)! {
            doneButton.isEnabled = false
        } else {
            doneButton.isEnabled = true
        }
    }
    
    // MARK: - Table Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        movieNameTextField.becomeFirstResponder()
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        movieNameTextField.endEditing(true)
    }
}

extension AddTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        movieNameTextField.endEditing(true)
        return true
    }
}
