//
//  MovieDetailViewController.swift
//  MoviesMobileApp
//
//  Created by Kirill Surelo on 28.12.2023.
//

import UIKit

protocol MovieDetailDelegate: AnyObject {
    func didAddToWatchlist(movie: Movie)
}

class MovieDetailViewController: UIViewController {
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var releaseDateLabel: UILabel!
  @IBOutlet weak var watchlistButton: UIButton!
  
  var movie: Movie?
  weak var delegate: MovieDetailDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
  }
  
  private func updateUI() {
    guard let movie = movie else { return }
    posterImageView.image = movie.posterImage
    titleLabel.text = movie.title
    descriptionLabel.text = movie.description
    ratingLabel.text = "\(movie.rating)"
    genreLabel.text = movie.genre
    releaseDateLabel.text = movie.releaseDate
    
    let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12.0)
        ]
    let attributedText = NSAttributedString(string: movie.isOnWatchlist ? "REMOVE FROM WATCHLIST" : "+ ADD TO WATCHLIST", attributes: attributes)
    
    watchlistButton.setAttributedTitle(attributedText, for: .normal)
    watchlistButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
  }
  
  @IBAction private func addToWatchlistButtonTapped(_ sender: UIButton) {
    movie?.isOnWatchlist.toggle()
    if let movie = movie {
      delegate?.didAddToWatchlist(movie: movie)
      updateUI()
    }
  }
  
  @IBAction private func trailerLinkButtonTapped(_ sender: UIButton) {
    if let movie = movie, let trailerURL = URL(string: movie.trailerLink) {
      UIApplication.shared.open(trailerURL, options: [:], completionHandler: nil)
    }
  }
}
