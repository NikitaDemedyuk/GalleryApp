//
//  GalleryCollectionView.swift
//  GalleryApp(BGSoft)
//
//  Created by Никита on 21.02.22.
//

import UIKit

class GalleryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var profiles = [Profile]()

    let cache = NSCache<NSNumber, UIImage>()
    let utilityQueue = DispatchQueue.global(qos: .utility)
    
    init() {
        let layout = GalleryCollectionFlowLayout(/*itemSize: CGSize(width: ConstantsBackgroundView.galleryItemWidth, height: ConstantsBackgroundView.galleryItemHeight)*/)
        super.init(frame: .zero, collectionViewLayout: layout)
        self.backgroundColor = .white
        
        setupDelegate()
        
        contentInset = UIEdgeInsets(top: ConstantsBackgroundView.topDistanceToView, left: ConstantsBackgroundView.leftDistanceToView, bottom: ConstantsBackgroundView.bottomDistanceToView, right: ConstantsBackgroundView.rightDistanceToView)
    
        register(imageCollectionViewCell.self, forCellWithReuseIdentifier: imageCollectionViewCell.identifier)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = true
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDelegate() {
        delegate = self
        dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ConstantsBackgroundView.galleryItemWidth, height: ConstantsBackgroundView.galleryItemHeight)
    }
     
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profiles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let userId = profiles[indexPath.row].id else {
            return UICollectionViewCell()
        }
        let itemNumber = NSNumber(value: indexPath.item)
        let imageURLString = "https://dev.bgsoft.biz/task/" + "\(userId)" + ".jpg"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCollectionViewCell.identifier, for: indexPath) as? imageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.nameLabel.text = profiles[indexPath.row].user_name
        if let cachedImage = self.cache.object(forKey: itemNumber) {
            print("Using a cached image for item: \(itemNumber)")
            cell.imageView.image = cachedImage
        } else {
            cell.configure(urlString: imageURLString) { image in
                guard let image = image else { return }
                cell.imageView.image = image
                self.cache.setObject(image, forKey: itemNumber)
            }
        }
        return cell
    }
    
    func fetchPhotos() {
        guard let url = URL(string: "https://dev.bgsoft.biz/task/credits.json") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            print("Got data!")
            
            do {
                let jsonProfiles = try JSONDecoder().decode(ProfileArray.self, from: data)
                DispatchQueue.main.async() {
                    self?.profiles = jsonProfiles.profiles
                    self?.reloadData()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}



