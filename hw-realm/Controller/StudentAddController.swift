//
//  StudentAddController.swift
//  hw-realm
//
//  Created by Mykhailo Tsyba on 2/25/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import UIKit
import RealmSwift

class StudentAddController: UIViewController {

	@IBOutlet weak var headerView: UIView!
	@IBOutlet weak var headerLabel: UILabel!
	@IBOutlet weak var contentView: UIView!
	@IBOutlet weak var nameView: UIView!
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var surnameView: UIView!
	@IBOutlet weak var surnameTextField: UITextField!
	@IBOutlet weak var ageView: UIView!
	@IBOutlet weak var ageTextField: UITextField!
	@IBOutlet weak var cityView: UIView!
	@IBOutlet weak var cityTextField: UITextField!
	@IBOutlet weak var phoneView: UIView!
	@IBOutlet weak var phoneTextField: UITextField!
	@IBOutlet weak var addStudentButton: UIButton!
	@IBOutlet weak var backButton: UIButton!

	@IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!

	var realmService = RealmService.shared
	var studentsArray = [StudentModelRealm]()
	var isValid = false

	override func viewDidLoad() {
		super.viewDidLoad()
		designUI()
		nameTextField.delegate = self
		surnameTextField.delegate = self
		ageTextField.delegate = self
		cityTextField.delegate = self
		phoneTextField.delegate = self
	}

	@IBAction func didTapAddButton(_ sender: Any) {
		validate()
		if isValid {
			addStudentToRealm()
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let vc = storyboard.instantiateViewController(identifier: "StudentListController") as! StudentListController
			navigationController?.pushViewController(vc, animated: true)
		} else {
			alertValidation()
		}
	}

	@IBAction func didTapBackButton(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}
}

//MARK: - UITextFieldDelegate
extension StudentAddController: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		scrollViewBottomConstraint.constant = 280
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {

		switch textField {
		case nameTextField:
			surnameTextField.becomeFirstResponder()
		case surnameTextField:
			ageTextField.becomeFirstResponder()
		case ageTextField:
			cityTextField.becomeFirstResponder()
		case cityTextField:
			phoneTextField.becomeFirstResponder()
		case phoneTextField:
			phoneTextField.resignFirstResponder()
		scrollViewBottomConstraint.constant = 0
		default:
			phoneTextField.resignFirstResponder()
			scrollViewBottomConstraint.constant = 0
		}
		return true
	}
}

//MARK: - StudentAddController extension
extension StudentAddController {

	func validate() {
		validateName()
		validateSurname()
		validateAge()
		validateCity()
		validatePhone()
	}

	func validateName() {
		if let text = nameTextField.text, !text.isEmpty {
			isValid = true
		} else {
			isValid = false
		}
	}

	func validateSurname() {
		if let text = surnameTextField.text, !text.isEmpty {
			isValid = true
		} else {
			isValid = false
		}
	}

	func validateAge() {
		if let text = ageTextField.text, !text.isEmpty {
			isValid = true
		} else {
			isValid = false
		}
	}

	func validateCity() {
		if let text = cityTextField.text, !text.isEmpty {
			isValid = true
		} else {
			isValid = false
		}
	}

	func validatePhone() {
		if let text = phoneTextField.text, !text.isEmpty {
			isValid = true
		} else {
			isValid = false
		}
	}

	//MARK: - alertValidation
	func alertValidation() {
		let alertController = UIAlertController(title: "Attention", message: "Please fill in ALL fields!", preferredStyle: .alert)
		let actionOK = UIAlertAction(title: "Ok", style: .default)
		alertController.addAction(actionOK)
		present(alertController, animated: true, completion: nil)
	}

	//MARK: - DesignUI
	func designUI() {
		designView(view: headerView)
		designView(view: nameView)
		designView(view: surnameView)
		designView(view: ageView)
		designView(view: cityView)
		designView(view: phoneView)
		designView(view: addStudentButton)
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

extension StudentAddController {
	func addStudentToRealm() {
		let student = StudentModelRealm()
		student.name = nameTextField.text ?? ""
		student.surname = surnameTextField.text ?? ""
		if let age = ageTextField.text {
			student.age = Int(age) ?? 0
		}
		student.city = cityTextField.text ?? ""
		student.phone = phoneTextField.text ?? ""

		studentsArray.append(student)
		realmService.addStudent(students: studentsArray)
	}
}

