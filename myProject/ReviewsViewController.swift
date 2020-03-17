//
//  ReviewsViewController.swift
//  myProject
//
//  Created by MacOSSierra on 3/16/20.
//  Copyright © 2020 JETS. All rights reserved.
//

import UIKit
import Alamofire

class ReviewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var reviewMovies : [NSDictionary]?
    var i = 1
    var movId = 0
    
    
    
    @IBOutlet weak var reviewsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewsTable.delegate = self
        reviewsTable.dataSource = self
        getReview(Id: movId)
    
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return reviewMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! ReviewCell
        let review = reviewMovies?[indexPath.row]
        let key = review?["author"] as? String ?? " "
        let key2 = review?["content"] as? String ?? " "
        
        print("Review Table",key)
        print("Review Table",key2)
        
        cell.authorLabel3?.text = "Author: " + key
        
       cell.contactLabel3?.text = "Comment: " + key2
        
        cell.backgroundColor = UIColor.lightGray
    
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getReview(Id:Int) {
        let urljson = "https://api.themoviedb.org/3/movie/\(movId)/reviews?api_key=91149f25a49924f7cdf7163334355b0f"
        Alamofire.request(urljson).responseJSON
            { response in switch response.result {
                
            case .success(let JSON):
                let response = JSON as! NSDictionary
                let ArrayOfMovies = response.object(forKey: "results")! as! NSArray
                self.reviewMovies = ArrayOfMovies as? [NSDictionary]
                self.reviewsTable.reloadData()
                
            case .failure(let error):
                print("Request failed with error: \(error)")
                }
        }
    }

}
