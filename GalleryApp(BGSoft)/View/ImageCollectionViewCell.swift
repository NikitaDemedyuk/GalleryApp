//
//  ImageCollectionViewCell.swift
//  GalleryApp(BGSoft)
//
//  Created by Никита on 21.02.22.
//

import Foundation
import UIKit

class imageCollectionViewCell: UICollectionViewCell {
    static let identifier = "imageCollectionViewCell"
    
    var imageCache = NSCache<NSString, UIImage>()
   
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = ConstantsBackgroundView.cornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let imageBackgroundView: UIView = {
        let imageBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: ConstantsBackgroundView.galleryItemWidth, height: ConstantsBackgroundView.galleryItemHeight))
        imageBackgroundView.clipsToBounds = false
        imageBackgroundView.layer.shadowColor = UIColor.black.cgColor
        imageBackgroundView.layer.shadowOpacity = Float(ConstantsBackgroundView.shadowOpacity)
        imageBackgroundView.layer.shadowOffset = CGSize.zero
        imageBackgroundView.layer.shadowRadius = ConstantsBackgroundView.shadowRadius
        imageBackgroundView.layer.shadowPath = UIBezierPath(roundedRect: imageBackgroundView.bounds, cornerRadius: ConstantsBackgroundView.cornerRadius).cgPath
        return imageBackgroundView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: ConstantsNameLabel.nameLabelFontSize)
        label.font = UIFont.systemFont(ofSize: ConstantsNameLabel.nameLabelFontSize, weight: .light)
        label.textAlignment = .center;
        label.textColor = .white
        label.numberOfLines = ConstantsNameLabel.nameLabelNumberLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(imageBackgroundView)
        addSubview(imageView)
        addSubview(nameLabel)
        
        setConstraints()
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

    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageBackgroundView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageBackgroundView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: imageBackgroundView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: imageBackgroundView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: ConstantsNameLabel.nameLabelDistanceToTop),
            nameLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: ConstantsNameLabel.nameLabelDistanceToLeft),
            nameLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: ConstantsNameLabel.nameLabelDistanceToRight),
            nameLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: ConstantsNameLabel.nameLabelDistanceToBottom)
        ])
    }
    
    func configure(urlString: String, completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                completion(image)
            }
        }.resume()
    }
}

