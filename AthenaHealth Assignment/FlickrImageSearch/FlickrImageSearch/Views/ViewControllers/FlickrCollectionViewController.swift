//
//  FlickrCollectionViewController.swift
//  FlickrImageSearch
//
//  Created by RAHUL ANANTULWAR on 26/03/21.
//  Copyright © 2021 RAHUL ANANTULWAR. All rights reserved.
//

import UIKit

class FlickrCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var searchBarController: UISearchController!
    private var numberOfColumns: CGFloat = 3.0 // Making hard coded number of columns as 3
    private var viewModel = ViewModel()
    private var isFirstTimeActive = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        viewModelClosures()
        if UserDefaults.standard.bool(forKey: StaticStrings.shared.firstLaunchStr) == false { // To show user guide
            showUserGuide()
            UserDefaults.standard.set(true, forKey: StaticStrings.shared.firstLaunchStr)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isFirstTimeActive {
            searchBarController.isActive = true
            isFirstTimeActive = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func showAlert(title: String = StaticStrings.shared.flickr, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title:NSLocalizedString(StaticStrings.shared.ok, comment: StaticStrings.shared.emptyString), style: UIAlertActionStyle.default) {(action) in
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

//MARK:- Configure UI for flicker images
extension FlickrCollectionViewController {
    
    fileprivate func configureUI() {
        
        createSearchBar()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(nib: ImageCollectionViewCell.nibName)
    }
}

//MARK:- Extension for Clousers
extension FlickrCollectionViewController {
    
    fileprivate func viewModelClosures() {
        
        viewModel.showAlert = { [weak self] (message) in
            self?.searchBarController.isActive = false
            self?.showAlert(message: message)
        }
        
        viewModel.dataUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func loadNextPage() {
        viewModel.fetchNextPage {
            //next page fetched
        }
    }
    
    private func showUserGuide() {
        let alert = UIAlertController(title: StaticStrings.shared.userGuide, message: StaticStrings.shared.userGuideMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString(StaticStrings.shared.ok, comment: StaticStrings.shared.emptyString), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension FlickrCollectionViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    private func createSearchBar() {
        searchBarController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchBarController
        searchBarController.delegate = self
        searchBarController.searchBar.delegate = self
        searchBarController.dimsBackgroundDuringPresentation = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text, text.count > 1 else {
            return
        }
        
        collectionView.reloadData()
        
        viewModel.search(text: text) {
            //search completed
        }
        
        searchBarController.searchBar.resignFirstResponder()
    }
    
}

//MARK:- UICollectionViewDataSource
extension FlickrCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.photoArray.count > 0 { // To handle no data label condition
            self.collectionView.restore()
            return viewModel.photoArray.count
        } else {
            self.collectionView.setEmptyMessage(StaticStrings.shared.noDataToShow)
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.nibName, for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = nil
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ImageCollectionViewCell else {
            return
        }
        
        let model = viewModel.photoArray[indexPath.row]
        cell.model = ImageModel.init(withPhotos: model)
        
        if indexPath.row == (viewModel.photoArray.count - 10) {
            loadNextPage()
        }
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension FlickrCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width)/numberOfColumns, height: (collectionView.bounds.width)/numberOfColumns)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



