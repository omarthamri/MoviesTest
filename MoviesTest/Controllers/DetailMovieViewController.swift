//
//  DetailMovieViewController.swift
//  MoviesTest
//
//  Created by omar thamri on 20/5/2024.
//

import UIKit
import SDWebImage
import Combine

class DetailMovieViewController: UIViewController {
    
    var viewModel: DetailViewModel?
    var cancellables: Set<AnyCancellable> = []
    
    var movieImageView: UIImageView = {
        var movieImageView = UIImageView()
        movieImageView.round(5)
        movieImageView.contentMode = .scaleToFill
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        return movieImageView
    }()
    
    let titleLbl: UILabel = {
        let nameLbl = UILabel()
        nameLbl.textColor = UIColor(named: "TextColor")
        nameLbl.font = UIFont.boldSystemFont(ofSize: 22)
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        return nameLbl
    }()
    
    let dateLbl: UILabel = {
        let dateLbl = UILabel()
        dateLbl.textColor = UIColor(named: "TextColor")
        dateLbl.font = UIFont.systemFont(ofSize: 18)
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        return dateLbl
    }()
    
    let descriptionTextView: UITextView = {
        let descriptionTextView = UITextView()
        descriptionTextView.backgroundColor = UIColor(named: "BackgroundColor")
        descriptionTextView.textColor = UIColor(named: "TextColor")
        descriptionTextView.sizeToFit()
        descriptionTextView.font = UIFont.systemFont(ofSize: 18)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        return descriptionTextView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureConstraints()
        fetchMovieDetails(movieId: 12345) // Replace with actual movieId
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(movieImageView)
        view.addSubview(titleLbl)
        view.addSubview(dateLbl)
        view.addSubview(descriptionTextView)
    }
    
    private func configureConstraints() {
        movieImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[movieImageView(280)]-12-[titleLbl(25)]-8-[dateLbl(22)]-12-[descriptionTextView]-8-|", metrics: nil, views: ["movieImageView":movieImageView,"titleLbl":titleLbl,"dateLbl":dateLbl,"descriptionTextView":descriptionTextView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[titleLbl]-4-|", metrics: nil, views: ["titleLbl":titleLbl]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[dateLbl]-4-|", metrics: nil, views: ["dateLbl":dateLbl]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[descriptionTextView]-4-|", metrics: nil, views: ["descriptionTextView":descriptionTextView]))
    }
    
    init(movieId: Int) {
        super.init(nibName: nil, bundle: nil)
        self.fetchMovieDetails(movieId: movieId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchMovieDetails(movieId: Int) {
        APICaller.shared.getMoviesDetails(movieId: movieId) { [weak self] result in
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    self?.viewModel = DetailViewModel(movieId: movieId)
                    self?.viewModel?.movie = movie
                    self?.bindViews()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    // Handle error (show alert, placeholder, etc.)
                }
            }
        }
    }
    
    private func bindViews() {
        guard let viewModel = viewModel else { return }
        viewModel.$movie
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movie in
                self?.titleLbl.text = movie?.original_title
                self?.dateLbl.text = movie?.release_date
                self?.descriptionTextView.text = movie?.overview
                if let url = URL(string: "https://image.tmdb.org/t/p/w500/\(movie?.backdrop_path ?? "")") {
                    self?.movieImageView.sd_setImage(with: url)
                }
            }
            .store(in: &cancellables)
    }
}
