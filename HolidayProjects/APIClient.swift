//
//  APIClient.swift
//  HolidayProjects
//
//  Created by Alex Paul on 1/9/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation
import NetworkHelper

struct APIClient {
  static func getProjects(completion: @escaping (Result<[Project], AppError>) -> ()) {
    let endpointURLString = "https://5e17daa8eaa1d2001436dd3c.mockapi.io/projects"
    guard let url = URL(string: endpointURLString) else {
      completion(.failure(.badURL(endpointURLString)))
      return
    }
    let request = URLRequest(url: url)
    NetworkHelper.shared.performDataTask(with: request) { (result) in
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success(let data):
        do {
          let projects = try JSONDecoder().decode([Project].self, from: data)
          completion(.success(projects))
        } catch {
          completion(.failure(.decodingError(error)))
        }
      }
    }
  }
}
