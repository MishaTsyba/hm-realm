//
//  StudentMenuController.swift
//  hw-realm
//
//  Created by Mykhailo Tsyba on 2/25/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import UIKit

class StudentMenuController: UIViewController {

	//MARK: - Outlet variables
	@IBOutlet weak var addStudentView: UIView!
	@IBOutlet weak var addStudentLabel: UILabel!
	@IBOutlet weak var listAllStudentsView: UIView!
	@IBOutlet weak var listAllStudentsLabel: UILabel!
	@IBOutlet weak var deleteAllStudentsView: UIView!
	@IBOutlet weak var deleteAllStudentsLabel: UILabel!
	@IBOutlet weak var deleteSelectedStudentView: UIView!
	@IBOutlet weak var deleteSelectedStudentLabel: UILabel!

	//MARK: - Custom variables
	var realmService = RealmService.shared
	var isDeleteSelectedStudent = false

	//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
		designUI()
    }

	//MARK: - @IBActions
	@IBAction func didTapAddStudentButton(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(identifier: "StudentAddController") as! StudentAddController
		navigationController?.pushViewController(vc, animated: true)
	}

	@IBAction func didTapDeleteAllStudentsButton(_ sender: Any) {
		alertDeleteAllStudents()
		realmService.deleteAllData()
	}

	@IBAction func listAllStudentsButton(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(identifier: "StudentListController") as! StudentListController
		navigationController?.pushViewController(vc, animated: true)
	}

	@IBAction func didTapDeleteSelectedStudentButton(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(identifier: "StudentListController") as! StudentListController
		self.isDeleteSelectedStudent = true
		vc.isDeleteSelectedStudent = self.isDeleteSelectedStudent
		navigationController?.pushViewController(vc, animated: true)
	}

}

//MARK: - Controller Extensions
extension StudentMenuController {
	//MARK: - alertDeleteAllStudents
	func alertDeleteAllStudents() {
		let alertController = UIAlertController(title: "Attention", message: "You are going to delete All Data!", preferredStyle: .alert)
		let actionOK = UIAlertAction(title: "Ok", style: .default)
		alertController.addAction(actionOK)
		present(alertController, animated: true, completion: nil)
	}

	//MARK: - DesignUI
	func designUI() {
		designView(view: addStudentView)
		designView(view: listAllStudentsView)
		designView(view: deleteAllStudentsView)
		designView(view: deleteSelectedStudentView)
	}

	func designView(view: UIView) {
		view.layer.borderWidth = 0.8
		view.layer.borderColor = UIColor(red: 253/255, green: 203/255, blue: 110/255, alpha: 1.0).cgColor
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowRadius = 3
		view.layer.shadowOpacity = 2
		view.layer.shadowOffset = CGSize(width: 0, height: 0)
	}
}
