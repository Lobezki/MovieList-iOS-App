//
//  MoviesViewController.swift
//  MoviesMobileApp
//
//  Created by Kirill Surelo on 28.12.2023.
//

import UIKit

import UIKit

class MoviesViewController: UITableViewController {
  private var movies: [Movie] = []
  
  var isSortingByTitle = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    
    let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortButtonTapped))
    navigationItem.rightBarButtonItem = sortButton
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Movies"
    loadMovies()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    reloadMovies()
  }
  
  @IBAction private func sortButtonTapped(_ sender: UIBarButtonItem) {
    let actionSheet = UIAlertController(title: "Sort By", message: nil, preferredStyle: .actionSheet)
    
    let sortByTitleAction = UIAlertAction(title: "Title", style: .default) { _ in
      self.sortMovies(by: "title")
    }
    
    let sortByReleaseDateAction = UIAlertAction(title: "Release Date", style: .default) { _ in
      self.sortMovies(by: "releaseDate")
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    actionSheet.addAction(sortByTitleAction)
    actionSheet.addAction(sortByReleaseDateAction)
    actionSheet.addAction(cancelAction)
    
    present(actionSheet, animated: true, completion: nil)
  }
  
  private func loadMovies() {
    movies = [
      Movie(posterImage: UIImage(named: "Tenet"), title: "Tenet", description: "Armed with only one word, Tenet, and fighting for the survival of the entire world, a Protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real-time.", rating: 7.8, duration: "2h 30min", genre: "Action, Sci-Fi", releaseDate: "3 September 2020", trailerLink: "https://www.youtube.com/watch?v=LdOM0x0XDMo", isOnWatchlist: false),
      Movie(posterImage: UIImage(named: "Spider Man"), title: "Spider-Man: Into the Spider-Verse", description: "Teen Miles Morales becomes the Spider-Man of his universe, and must join with five spider-powered individuals from other dimensions to stop a threat for all realities.", rating: 8.4, duration: "1h 57min", genre: "Action, Animation, Adventure", releaseDate: "14 December 2018", trailerLink: "https://www.youtube.com/watch?v=tg52up16eq0", isOnWatchlist: false),
      Movie(posterImage: UIImage(named: "Knives Out"), title: "Knives Out", description: "A detective investigates the death of a patriarch of an eccentric, combative family.", rating: 7.9, duration: "2h 10min", genre: "Comedy, Crime, Drama", releaseDate: "27 November 2019", trailerLink: "https://www.youtube.com/watch?v=qGqiHJTsRkQ", isOnWatchlist: false),
      Movie(posterImage: UIImage(named: "Guardians of The Galaxy"), title: "Guardians of the Galaxy", description: "A group of intergalactic criminals must pull together to stop a fanatical warrior with plans to purge the universe.", rating: 8.0, duration: "2h 1min", genre: "Action, Adventure, Comedy", releaseDate: "1 August 2014", trailerLink: "https://www.youtube.com/watch?v=d96cjJhvlMA", isOnWatchlist: false),
      Movie(posterImage: UIImage(named: "Avengers"), title: "Avengers: Age of Ultron", description: "When Tony Stark and Bruce Banner try to jump-start a dormant peacekeeping program called Ultron, things go horribly wrong and it's up to Earth's mightiest heroes to stop the villainous Ultron from enacting his terrible plan.", rating: 7.3, duration: "2h 21min", genre: "Action, Adventure, Sci-Fi", releaseDate: "1 May 2015", trailerLink: "https://www.youtube.com/watch?v=tmeOjFno6Do", isOnWatchlist: false)
    ]
  }
  
  private func reloadMovies() {
    tableView.reloadData()
  }
  
  private func sortMovies(by key: String) {
    switch key {
    case "title":
      movies.sort { $0.title < $1.title }
    case "releaseDate":
      movies.sort { $0.releaseDate < $1.releaseDate }
    default:
      break
    }
    tableView.reloadData()
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
    let movie = movies[indexPath.row]
    
    cell.movieImageView.image = movie.posterImage
    cell.movieTitleLabel.text = movie.title
    cell.detailsLabel.text = "\(movie.duration) - \(movie.genre)"
    cell.onMyWatchlistView.isHidden = !movie.isOnWatchlist
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let movieDetailVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
    movieDetailVC.movie = movies[indexPath.row]
    movieDetailVC.delegate = self
    navigationController?.pushViewController(movieDetailVC, animated: true)
  }
}

extension MoviesViewController: MovieDetailDelegate {
  func didAddToWatchlist(movie: Movie) {
    if let index = movies.firstIndex(where: { $0.title == movie.title }) {
      movies[index].isOnWatchlist.toggle()
    }
  }
}
