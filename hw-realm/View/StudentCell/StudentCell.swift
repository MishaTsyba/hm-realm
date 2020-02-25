//
//  StudentCell.swift
//  hw-realm
//
//  Created by Mykhailo Tsyba on 2/25/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import UIKit

class StudentCell: UITableViewCell {

	@IBOutlet weak var labelContainerView: UIView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var surnameLabel: UILabel!
	@IBOutlet weak var ageLabel: UILabel!
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var phoneLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        designUI()
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
		if selected {
			contentView.backgroundColor = UIColor.orange
		} else {
			contentView.backgroundColor = UIColor.white
		}
    }
}

extension StudentCell {
	//MARK: - DesignUI
	func designUI() {
		designView(view: labelContainerView)
	}

	func designView(view: UIView) {
		view.layer.borderWidth = 0.8
		view.layer.borderColor = UIColor(red: 253/255, green: 203/255, blue: 110/255, alpha: 1.0).cgColor
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowRadius = 3
		view.layer.shadowOpacity = 2
		view.layer.shadowOffset = CGSize(width: 0, height: 0)
	}

	//MARK: - updateStudentCell
	func updateStudentCell(student: StudentModelRealm) {
		nameLabel.text = "Name: " + student.name
		surnameLabel.text = "Surname: " + student.surname
		ageLabel.text = "Age: " + String(student.age)
		cityLabel.text = "City: " + student.city
		phoneLabel.text = "Phone: " + student.phone
	}
}
