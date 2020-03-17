//
//  MovieDetail.swift
//  myProject
//
//  Created by MacOSSierra on 3/15/20.
//  Copyright © 2020 JETS. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import YoutubePlayer_in_WKWebView

class MovieDetail: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var movtitle = ""
    var movreleaseDate = ""
    var over_View = ""
    var movImg = ""
    var movId = 0
    var videoMovies: [NSDictionary]?
    var i = 1

    
    @IBOutlet weak var videoTable: UITableView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var releaseData: UILabel!
    @IBOutlet weak var overView: UILabel!
    
    @IBOutlet weak var playerMovie: WKYTPlayerView!
    
    @IBAction func reviewsBtn(_ sender: Any) {
        
        
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let thirdVC = mainStoryBoard.instantiateViewController(withIdentifier: "reviewVC") as! ReviewsViewController
        thirdVC.movId = movId
        print("To Review Table ",thirdVC.movId)
        self.navigationController?.pushViewController(thirdVC, animated: true)
        
        
    }
    
    @IBAction func AddToFav(_ sender: Any) {
        
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = mainStoryBoard.instantiateViewController(withIdentifier: "secondVC") as! FavouriteTableViewController
        secondVC.text = movtitle
        print("text ",secondVC.text)
        self.navigationController?.pushViewController(secondVC, animated: true)
        
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        videoTable.dataSource = self
        videoTable.delegate = self
        movieTitle.text = movtitle
        releaseData.text = movreleaseDate
        imageView.sd_setImage(with: URL(string: movImg))
        overView.text = over_View
        print("movId ",movId)
        getVideo(Id: movId)
        playerMovie.isHidden = true
    }
    
    func getVideo(Id:Int) {
        let urljson = "https://api.themoviedb.org/3/movie/\(movId)/videos?api_key=91149f25a49924f7cdf7163334355b0f"
        Alamofire.request(urljson).responseJSON
            { response in switch response.result {
                
            case .success(let JSON):
                let response = JSON as! NSDictionary
                let ArrayOfMovies = response.object(forKey: "results")! as! NSArray
                self.videoMovies = ArrayOfMovies as? [NSDictionary]
                self.videoTable.reloadData()
                
            case .failure(let error):
                print("Request failed with error: \(error)")
                }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieCell
        let movie = videoMovies?[indexPath.row]
        let key = movie?["key"] as? String ?? " "
        print("Key",key)
        cell.movVideo.text = "Trailer \(i)"
        i=i+1
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = videoMovies?[indexPath.row]
        let key = movie?["key"] as? String ?? " "
        print("Key",key)
        playerMovie.isHidden = false
        playerMovie.load(withVideoId: key)
    }
    
}

