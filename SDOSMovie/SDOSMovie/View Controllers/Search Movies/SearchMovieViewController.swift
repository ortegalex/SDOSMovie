//
//  SearchMovieViewController.swift
//  SDOSMovie
//
//  Created by Alex Ortega on 28/12/2019.
//  Copyright © 2019 Alex Ortega. All rights reserved.
//

import UIKit

class SearchMovieViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var currentPage = 1
    private var searchText: String?
    private var shouldShowLoadingCell = false
    private var isLoadingList = false
    
    var movies = [Movie]()
    
    
    lazy var emptyView: MoviesEmptyView = {
        let ev = MoviesEmptyView(frame: self.view.frame)
        ev.setMessage(message: "Search a movie")
        return ev
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundView = emptyView
        self.searchBar.delegate = self

        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: MovieTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MovieTableViewCell.reuseIdentifier)
        
    }
    
    private func searchMovies(refresh: Bool = false) {
        let search = searchText ?? ""
        if refresh { EZLoadingActivity.show("Searching...", disableUI: true) }
        MovieAPIService.searchMovies(searchText: search, page: currentPage) {[weak self] (result:ResultHandler<SearchResult>) in
            EZLoadingActivity.hide()
            guard let strongSelf = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    strongSelf.reloadTable(result: result)
                case .failure(let error):
                    strongSelf.showAlertDialog(error, title: "Error", didClose: nil)
                }
            }
        }
    }
    
    private func fetchNextPage() {
        currentPage += 1
        searchMovies()
    }
    
    private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard shouldShowLoadingCell else { return false }
        return indexPath.row == self.movies.count
    }
    
    private func reloadTable(result: SearchResult) {
        self.tableView.backgroundView = nil
        if let moviesResult = result.movies {
            if currentPage == 1 {
                self.movies = moviesResult
            } else {
                self.movies.append(contentsOf: moviesResult)
            }
        } else {
            self.showAlertDialog("No se han encontrado peliculas con el título \(searchText ?? "")", title: "Aviso", didClose: nil)
            self.tableView.backgroundView = emptyView
            self.movies.removeAll()
        }
        
        if let totalResult = Int(result.totalResults ?? "0") {
            self.shouldShowLoadingCell = self.movies.count < totalResult
        }
        self.isLoadingList = false
        self.tableView.reloadData()
    }

}

// MARK: - UISearchBarDelegate
extension SearchMovieViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchText = searchBar.text
        guard searchText != nil && searchText!.count > 3 else {
            self.showAlertDialog("Introduce al menos 3 caracteres en la búsqueda.")
            return
        }
        currentPage = 1
        searchMovies(refresh: true)
        self.searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
}

// MARK: - UITableview DataSource
extension SearchMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = movies.count
        return shouldShowLoadingCell ? (count + 1) : count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingIndexPath(indexPath) {
            return LoadingCell(style: .default, reuseIdentifier: "loading")
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath) as! MovieTableViewCell
        cell.movie = movies[indexPath.row]
        return cell
    }
    
}

// MARK: - UITableview Delegate
extension SearchMovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList && shouldShowLoadingCell){
            self.isLoadingList = true
            self.fetchNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        let vc = DetailMovieViewController(with: movie.imdbID)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


