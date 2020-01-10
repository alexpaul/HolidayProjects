//
//  ProjectsViewController.swift
//  HolidayProjects
//
//  Created by Alex Paul on 1/9/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  private var projects = [Project]() {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
        self.navigationItem.title = "iOS 6.3 Holiday Projects (\(self.projects.count))"
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    fetchProjects()
  }
  
  private func fetchProjects() {
    APIClient.getProjects { [weak self] (result) in
      switch result {
      case .failure:
        break
      case .success(let projects):
        self?.projects = projects.sorted { $0.firstName < $1.firstName }
      }
    }
  }
}

extension ProjectsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return projects.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath)
    let project = projects[indexPath.row]
    cell.textLabel?.text = project.projectName
    cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    cell.detailTextLabel?.text = project.fullName
    cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
    return cell
  }
}

extension ProjectsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let detailController = storyboard?.instantiateViewController(identifier: "ProjectDetailController") as? ProjectDetailController else {
      fatalError("could not downcast to ProjectDetailController")
    }
    let project = projects[indexPath.row]
    detailController.project = project
    navigationController?.pushViewController(detailController, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
}
