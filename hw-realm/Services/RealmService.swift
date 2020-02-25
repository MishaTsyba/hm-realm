//
//  RealmService.swift
//  hw-realm
//
//  Created by Mykhailo Tsyba on 2/25/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {

	static let shared: RealmService = {
		let instance = RealmService()
		return instance
	}()

	func addStudent(students: [StudentModelRealm]) {
		do {
			let realm = try Realm()
			try realm.write {
				realm.add(students)
			}
		} catch {
			debugPrint("error writing students to realm")
		}
	}

	func getStudents() -> [StudentModelRealm] {
		do {
			let realm = try Realm()
			let students = realm.objects(StudentModelRealm.self)
			let studentsArray = Array(students)
			return studentsArray
		} catch {
			debugPrint("error getting students to realm")
			return []
		}
	}

	func deleteAllData() {
		do {
			let realm = try Realm()
			try realm.write {
				realm.deleteAll()
			}
		} catch {
			debugPrint("error deleting all data from realm")
		}
	}

	func deleteStudent(students: [StudentModelRealm]) {
		do {
			let realm = try Realm()
			try realm.write {
				let deleteArray = List<StudentModelRealm>()
				let deleteStudents = students.filter { (student) in
					student.isDelete == true
				}
				deleteArray.append(objectsIn: deleteStudents)
				realm.delete(deleteArray)
			}
		} catch {
			debugPrint("error deleting students from realm")
		}
	}
}
