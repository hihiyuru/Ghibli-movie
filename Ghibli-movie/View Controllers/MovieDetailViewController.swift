//
//  MovieDetailViewController.swift
//  Ghibli-movie
//
//  Created by 徐于茹 on 2023/8/18.
//

import UIKit
import Kingfisher
import WebKit

class MovieDetailViewController: UIViewController {
    var movieId: String!
    var movie: Movie?
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ProducerLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var tileLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setShadow()
        fetchMovieDetail()
    }
    
    func setShadow() {
        // 設定陰影的相關屬性
        posterImageView.layer.shadowColor = UIColor.black.cgColor
        posterImageView.layer.shadowOpacity = 0.5
        posterImageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        posterImageView.layer.shadowRadius = 6
    }
    
    func fetchMovieDetail() {
        guard let id = movieId else { return }
        let stringUrl = "https://ghibliapi.vercel.app/films/\(id)"
        guard let url = URL(string: stringUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data {
                let decoder = JSONDecoder()
                do {
                    self.movie = try decoder.decode(Movie.self, from: data)
                    DispatchQueue.main.async {
                        self.updateUI()
                    }
                } catch {
                    print(error)
                }
            }
            
            
        }.resume()
    }
    
    
    func updateUI() {
        if let movieBanner = movie?.movieBanner,
           let movieImage = movie?.image,
           let title = movie?.title,
           let year = movie?.releaseDate,
           let director = movie?.director,
           let producer = movie?.producer,
           let description = movie?.description
        {
            bannerImageView.kf.setImage(with: movieBanner)
            posterImageView.kf.setImage(with: movieImage)
            tileLabel.text = title
            yearLabel.text = year
            directorLabel.text = "Director: \(director)"
            ProducerLabel.text = "Producer: \(producer)"
            descriptionLabel.text = description
        }
        
    }
    
}
