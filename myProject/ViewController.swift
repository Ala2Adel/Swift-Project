//
//  viewControllerViewController.swift
//  myProject
//
//  Created by MacOSSierra on 3/15/20.
//  Copyright © 2020 JETS. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var movieTitle = ""
    var movies: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        getData()
    }
    @IBAction func undoAction(_ sender: Any) {
        getData()
    }
    
    @IBAction func sortByReleaseDate(_ sender: Any) {
    
        let urljson = "https://api.themoviedb.org/3/discover/movie?api_key=91149f25a49924f7cdf7163334355b0f&sort_by=release_date.desc"
        Alamofire.request(urljson).responseJSON
            { response in switch response.result {
            case .success(let JSON):
                let response = JSON as! NSDictionary
                let ArrayOfMovies = response.object(forKey: "results")! as! NSArray
                self.movies = ArrayOfMovies as? [NSDictionary]
                self.collectionView.reloadData()
            case .failure(let error):
                print("Request failed with error: \(error)")
                }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCollectionViewCell
        let movie = movies?[indexPath.row]
        let posterPath = movie?["poster_path"] as? String ?? " "
        let imgUrl = "http://image.tmdb.org/t/p/w185" + posterPath
        cell.movieImg.sd_setImage(with: URL(string: imgUrl))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies?[indexPath.row]
        let posterPath = movie?["poster_path"] as? String ?? " "
        let imgUrl = "http://image.tmdb.org/t/p/w185" + posterPath
        
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = mainStoryBoard.instantiateViewController(withIdentifier: "detailVC") as! MovieDetail
        secondVC.movtitle = movie?["title"] as? String ?? " "
        secondVC.movreleaseDate = movie?["release_date"] as? String ?? " "
        secondVC.movImg = imgUrl
        secondVC.movId = (movie?["id"] as? Int)!
        print("1st movId ",movie?["id"] as? Int ?? 0)
        secondVC.over_View = movie?["overview"] as? String ?? " "
        self.navigationController?.pushViewController(secondVC, animated: true)
        
    }
    
    func getData(){
        let urljson = "https://api.themoviedb.org/3/discover/movie?api_key=91149f25a49924f7cdf7163334355b0f&sort_by=popularity.desc"
        Alamofire.request(urljson).responseJSON
            { response in switch response.result {
            case .success(let JSON):
                let response = JSON as! NSDictionary
                let ArrayOfMovies = response.object(forKey: "results")! as! NSArray
                self.movies = ArrayOfMovies as? [NSDictionary]
                self.collectionView.reloadData()
                
            case .failure(let error):
                print("Request failed with error: \(error)")
                }
        }
    }
}
