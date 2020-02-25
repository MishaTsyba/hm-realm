//
//  StudentListController.swift
//  hw-realm
//
//  Created by Mykhailo Tsyba on 2/25/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import UIKit

class StudentListController: UIViewController {

	@IBOutlet weak var headerView: UIView!
	@IBOutlet weak var headerLabel: UILabel!
	@IBOutlet weak var studentsTableView: UITableView!
	@IBOutlet weak var backButton: UIButton!
	@IBOutlet weak var deleteButton: UIButton!

	var realmService = RealmService.shared
	var studentsArray = [StudentModelRealm]()
	var isDeleteSelectedStudent = false
	
    override func viewDidLoad() {
        super.viewDidLoad()
		designUI()
		deleteButton.isHidden = isDeleteSelectedStudent ? false : true
		studentsTableView.delegate = self
		studentsTableView.dataSource = self
		studentsTableView.register(UINib(nibName: "StudentCell", bundle: nil), forCellReuseIdentifier: "StudentCell")
		studentsArray = getStudents()
		studentsTableView.reloadData()
    }

	@IBAction func didTapDeleteButton(_ sender: Any) {
		deleteStudents(delete: studentsArray)
		studentsArray = getStudents()
		studentsTableView.reloadData()
	}

	@IBAction func didTapBackButton(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}
}

//MARK: - UITableViewDelegate
extension StudentListController: UITableViewDelegate, UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return studentsArray.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentCell
		cell.updateStudentCell(student: studentsArray[indexPath.row])
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		debugPrint("*********** StudentListController didSelectRowAt  **************")
		studentsArray[indexPath.row].isDelete = true
    }

	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		debugPrint("*********** didDeselectRowAt  studentsDeleteArray **************")
		studentsArray[indexPath.row].isDelete = false
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}

extension StudentListController {
	//MARK: - DesignUI
	func designUI() {
		designView(view: headerView)
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

extension StudentListController {
	//MARK: - getStudents
	func getStudents() -> [StudentModelRealm] {
		let students = realmService.getStudents()
		return students
	}

	//MARK: - deleteStudents
	func deleteStudents(delete students: [StudentModelRealm]) {
		realmService.deleteStudent(students: students)
	}
}
