//
//  MovieListViewController.swift
//  Ghibli-movie
//
//  Created by 徐于茹 on 2023/8/18.
//

import UIKit
import Kingfisher

class MovieListViewController: UIViewController {
    var movies: [Movie] = []
    var showMovies: [Movie] = []
    var selectedMovie: Movie?
    var selectedRow = 0
    
    @IBOutlet weak var ListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListTableView.dataSource = self // 設定 tableView 的 dataSource
        fetchMovieList()
    }
    
    func fetchMovieList() {
        let urlString = "https://ghibliapi.vercel.app/films"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data {
                let decoder = JSONDecoder()
                do {
                    self.movies = try decoder.decode([Movie].self, from: data)
                    self.showMovies = self.movies
                    DispatchQueue.main.async {
                        self.ListTableView.reloadData()
                    }
                } catch {
                    print("Erro decoding JSON: \(error)")
                }
            }
        }.resume()
        
    }
    
    @IBAction func clickMovie(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: ListTableView)
        if let indexPath = ListTableView.indexPathForRow(at: point) {
            print("在哪個row", indexPath.row)
            let rowIndex = indexPath.row
            let startRowMoviesIndex = rowIndex * 3
            let endRowMoviesIndex = min(startRowMoviesIndex + 3, showMovies.count)
            let rowMovies = Array(showMovies[startRowMoviesIndex..<endRowMoviesIndex])
            selectedMovie = rowMovies[sender.tag]
        }
    }
    
    
    
    @IBSegueAction func showDetail3(_ coder: NSCoder, sender: Any?) -> MovieDetailViewController? {
        let controller =  MovieDetailViewController(coder: coder)
        controller?.movieId = selectedMovie?.id
        return controller
    }
    @IBSegueAction func showDetail2(_ coder: NSCoder, sender: Any?) -> MovieDetailViewController? {
        let controller =  MovieDetailViewController(coder: coder)
        controller?.movieId = selectedMovie?.id
        return controller
    }
    @IBSegueAction func showDetail1(_ coder: NSCoder, sender: Any?) -> MovieDetailViewController? {
        let controller =  MovieDetailViewController(coder: coder)
        controller?.movieId = selectedMovie?.id
        return controller
    }
}

extension MovieListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, searchBar.text != ""{
            print("輸入的字", searchText)
            let searchMovie = movies.filter { movie in
                movie.title.contains(searchText)
            }
            showMovies = searchMovie
            ListTableView.reloadData() // 重新載入 TableView
            print("搜尋的電影", searchMovie)
        } else {
            showMovies = movies
            ListTableView.reloadData()
        }
        searchBar.resignFirstResponder() // 關閉鍵盤
    }
    
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showMovies.count / 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ListTableViewCell.self)", for: indexPath) as? ListTableViewCell else {
            fatalError("something wrong")
        }
        
        cell.selectionStyle = .none
        
        let startMovieIndex = indexPath.row * 3
        let endMovieIndex = min(startMovieIndex + 3, showMovies.count)
        let rowMovies = Array(showMovies[startMovieIndex..<endMovieIndex])
        
        for (index, label) in cell.movieNameLabels.enumerated() {
            if index < rowMovies.count {
                label.text = rowMovies[index].title
            } else {
                label.text = nil
            }
        }
        
        for (index, label) in cell.yearLabels.enumerated() {
            if index < rowMovies.count {
                label.text = rowMovies[index].releaseDate
            } else {
                label.text = nil
            }
        }
        
        for (index, pic) in cell.posterImageViews.enumerated() {
            if index < rowMovies.count {
                pic.kf.setImage(with: rowMovies[index].image)
            } else {
                pic.image = nil
            }
        }
        
        
        return cell
    }
    
    
}
