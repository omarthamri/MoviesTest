//
//  HomeViewController.swift
//  MoviesTest
//
//  Created by omar thamri on 20/5/2024.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel!
    var showDetailRequest: (_ row: Int) -> () = { row in }
    private var subscriptions: Set<AnyCancellable> = []
    private let moviesCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let mcv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            mcv.translatesAutoresizingMaskIntoConstraints = false
            return mcv
        }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureConstraints()
        bindView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchTrendingMovies()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(moviesCollectionView)
        view.addSubview(errorLabel)
        setupCollectionView()
    }
    
    private func configureConstraints() {
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[MovieCV]-12-|", metrics: nil, views: ["MovieCV":moviesCollectionView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-6-[MovieCV]-6-|", metrics: nil, views: ["MovieCV":moviesCollectionView]))
        let errorLabelConstraints = [
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            errorLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ]
        NSLayoutConstraint.activate(errorLabelConstraints)
    }
    
    private func setupCollectionView() {
            moviesCollectionView.delegate = self
            moviesCollectionView.dataSource = self
            moviesCollectionView.backgroundColor = .clear
            self.registerCells()
        }
            
        private func registerCells() {
            moviesCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        }
    
    private func bindView() {
        viewModel.$movies.sink { [weak self] movies in
            DispatchQueue.main.async {
                self?.moviesCollectionView.reloadData()
                self?.errorLabel.text = ""
            }
        }
        .store(in: &subscriptions)
        viewModel.$error.sink { [weak self] error in
            DispatchQueue.main.async {
                self?.errorLabel.text = error
            }
        }
        .store(in: &subscriptions)
    }
    
}


extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else { return UICollectionViewCell() }
            cell.nameLbl.text = viewModel.movies[indexPath.row].name ?? viewModel.movies[indexPath.row].original_title ?? ""
            cell.dateLbl.text = viewModel.movies[indexPath.row].release_date?.convertDateToYear() ?? ""
            if let url = URL(string: "https://image.tmdb.org/t/p/w500/\(String(describing: viewModel.movies[indexPath.row].poster_path ?? ""))" ) {
                cell.movieImageView.sd_setImage(with: url)
            }
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width - 4, height: 150)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 20
            }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetailRequest(indexPath.row)
    }
    

    
}

