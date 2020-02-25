//
//  StudentModelRealm.swift
//  hw-realm
//
//  Created by Mykhailo Tsyba on 2/25/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import Foundation
import RealmSwift

class StudentModelRealm: Object {
	@objc dynamic var name: String = ""
	@objc dynamic var surname: String = ""
	@objc dynamic var age: Int = 0
	@objc dynamic var city: String = ""
	@objc dynamic var phone: String = ""
	var isDelete: Bool?
}
