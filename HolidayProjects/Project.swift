//
//  Project.swift
//  HolidayProjects
//
//  Created by Alex Paul on 1/9/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct Project: Codable {
  let firstName: String
  let lastName: String
  let projectName: String
  let githubURL: String
  let imageURL: String
  let description: String
  
  var fullName: String {
    return firstName + " " + lastName
  }
}
