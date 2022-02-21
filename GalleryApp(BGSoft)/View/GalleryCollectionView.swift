//
//  GalleryCollectionView.swift
//  GalleryApp(BGSoft)
//
//  Created by Никита on 21.02.22.
//

import UIKit

class GalleryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var profiles = [Profile]()
    
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        self.backgroundColor = .white
        layout.scrollDirection = .horizontal
        
        delegate = self
        dataSource = self
        
        contentInset = UIEdgeInsets(top: 0, left: Constants.leftDistanceToView, bottom: 0, right: Constants.leftDistanceToView)
        //layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumLineSpacing = Constants.galleryMinimumLineSpacing
        layout.minimumInteritemSpacing = 50
        register(imageCollectionViewCell.self, forCellWithReuseIdentifier: imageCollectionViewCell.identifier)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    private var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
        layout.minimumLineSpacing = 50
        layout.minimumInteritemSpacing = 50
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(imageCollectionViewCell.self, forCellWithReuseIdentifier: imageCollectionViewCell.identifier)
        return collectionView
    }()
     
    */
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.galleryItemWidth, height: Constants.galleryItemHeight)
    }
     
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profiles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageURLString = "https://dev.bgsoft.biz/task/" + "\(profiles[indexPath.row].id!)" + ".jpg"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCollectionViewCell.identifier, for: indexPath) as? imageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.nameLabel.text = profiles[indexPath.row].user_name
        cell.configure(with: imageURLString)
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
                DispatchQueue.main.async {
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

struct Constants {
    static let leftDistanceToView: CGFloat = 10
    static let rightDistanceToView: CGFloat = 10
    static let galleryMinimumLineSpacing: CGFloat = 50
    static let galleryItemWidth = UIScreen.main.bounds.width - Constants.leftDistanceToView - Constants.rightDistanceToView - Constants.galleryMinimumLineSpacing
    static let galleryItemHeight = UIScreen.main.bounds.height * 0.8
}

