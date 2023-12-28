//
//  Movie.swift
//  MoviesMobileApp
//
//  Created by Kirill Surelo on 28.12.2023.
//

import UIKit

struct Movie: Equatable {
  var posterImage: UIImage?
  var title: String
  var description: String
  var rating: Double
  var duration: String
  var genre: String
  var releaseDate: String
  var trailerLink: String
  var isOnWatchlist: Bool
}
