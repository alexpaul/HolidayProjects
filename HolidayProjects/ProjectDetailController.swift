//
//  ViewController.swift
//  HolidayProjects
//
//  Created by Alex Paul on 1/9/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import ImageKit

class ProjectDetailController: UIViewController {
  
  @IBOutlet weak var firstNameLabel: UILabel!
  @IBOutlet weak var lastNameLabel: UILabel!
  @IBOutlet weak var githubButton: UIButton!
  @IBOutlet weak var projectImageView: UIImageView!
  @IBOutlet weak var descriiptionLabel: UILabel!
  
  var project: Project? {
    didSet {
      DispatchQueue.main.async {
        self.updateUI()
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  private func updateUI() {
    guard let project = project else {
      return
    }
    navigationItem.title = project.projectName
    
    // TODO: uncomment below when all outlets are connected to the ScrollView
    /*
    firstNameLabel.text = project.firstName
    lastNameLabel.text = project.lastName
    descriiptionLabel.text = project.description
    projectImageView.getImage(with: project.imageURL) { [weak self] (result) in
      switch result {
      case .failure(let appError):
        print("error fetching image \(appError)")
      case .success(let image):
        DispatchQueue.main.async {
          self?.projectImageView.image = image
        }
      }
    }
    */
  }
  
  // TODO: add an action to open up a given Github page via SFSafariViewController
  
}

