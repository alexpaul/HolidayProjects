//
//  ViewController.swift
//  HolidayProjects
//
//  Created by Alex Paul on 1/9/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import ImageKit
import SafariServices

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
    
  }
  
  @IBAction func githubButtonPressed(_ sender: UIButton) {
    guard let project = project else {
      fatalError("project was not passesd successfully")
    }
    guard let url = URL(string: project.githubURL),
      !project.githubURL.isEmpty else {
        print("no project url")
        return
    }
    let safariVC = SFSafariViewController(url: url)
    present(safariVC, animated: true)
  }
  
}

