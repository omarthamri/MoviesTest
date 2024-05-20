//
//  MovieCell.swift
//  MoviesTest
//
//  Created by omar thamri on 20/5/2024.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    
    var view: UIView = {
       var view = UIView()
        view.backgroundColor = UIColor(named: "MovieCellBackground")
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    let movieImageView: UIImageView = {
        let movieImageView = UIImageView()
        movieImageView.contentMode = .scaleToFill
        movieImageView.round(5)
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        return movieImageView
    }()
    
    let nameLbl: UILabel = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .clear
        round()
        addBorder(color: .label, width: 1)
        addSubview(view)
        view.addSubview(movieImageView)
        view.addSubview(nameLbl)
        view.addSubview(dateLbl)
    }
    
    func setupConstraints() {
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", metrics: nil, views: ["view":view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", metrics: nil, views: ["view":view]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[movieImageView(100)]-4-[nameLbl]-4-|", metrics: nil, views: ["movieImageView":movieImageView,"nameLbl":nameLbl]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[movieImageView]-4-|", metrics: nil, views: ["movieImageView":movieImageView]))
        nameLbl.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: 4).isActive = true
        nameLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        dateLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 4).isActive = true
        dateLbl.heightAnchor.constraint(equalTo: nameLbl.heightAnchor).isActive = true
        dateLbl.widthAnchor.constraint(equalTo: nameLbl.widthAnchor).isActive = true
        dateLbl.leadingAnchor.constraint(equalTo: nameLbl.leadingAnchor).isActive = true
        
    }
    
}
