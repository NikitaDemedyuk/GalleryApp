//
//  ImageCollectionViewCell.swift
//  GalleryApp(BGSoft)
//
//  Created by Никита on 21.02.22.
//

import UIKit

class imageCollectionViewCell: UICollectionViewCell {
    static let identifier = "imageCollectionViewCell"
    
   
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let imageBackgroundView: UIView = {
        let imageBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.galleryItemWidth, height: Constants.galleryItemHeight))
        imageBackgroundView.clipsToBounds = false
        imageBackgroundView.layer.shadowColor = UIColor.black.cgColor
        imageBackgroundView.layer.shadowOpacity = 0.75
        imageBackgroundView.layer.shadowOffset = CGSize.zero
        imageBackgroundView.layer.shadowRadius = 8
        imageBackgroundView.layer.shadowPath = UIBezierPath(roundedRect: imageBackgroundView.bounds, cornerRadius: 30).cgPath
        return imageBackgroundView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 32.0)
        label.font = UIFont.systemFont(ofSize: 32.0, weight: .light)
        label.textAlignment = .center;
        label.textColor = .white
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(imageBackgroundView)
        addSubview(imageView)
        addSubview(nameLabel)
        
        imageBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageBackgroundView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageBackgroundView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        imageBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: imageBackgroundView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: imageBackgroundView.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 500).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 10).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.imageView.image = image
            }
        }.resume()
    }
    
}

