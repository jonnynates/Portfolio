//
//  ArtworkView.swift
//  Assignment 2
//
//  Created by Jonathan Nates on 05/12/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//

import UIKit
import CoreData

class ArtworkView: UIViewController {
    
    //artIndex points to the first item in core data (after being sorted)
    var artIndex = 0
    //The title of the artwork being displayed
    var artTitle = ""

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var imgArt: UIImageView!
    
    //Button that transfers the view back to the map screen
    @IBAction func btnBack(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fetchRequest: NSFetchRequest<Artwork> = Artwork.fetchRequest()
        do
        {
            let sortDescriptor = NSSortDescriptor(key: "distance", ascending: true)
            let sortDescriptors = [sortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
            //print(artTitle)
            //Searches core data for the art title
            fetchRequest.predicate = NSPredicate(format: "title MATCHES[cd] '(\(artTitle)).*'")
            let fetchResults = try PersistenceService.context.fetch(fetchRequest)
            let results = fetchResults as [Artwork] //Core Data
            
            //Sets up all the labels on the view
            lblTitle.text = results[artIndex].title
            lblArtist.text = results[artIndex].artist
            lblYear.text = results[artIndex].yearOfWork
            lblInfo.text = results[artIndex].information
            lblLocation.text = "\(results[artIndex].location!) :"
            lblDistance.text = "\(Int(results[artIndex].distance))m"
            
            //Store images
            let imgURLString = "https://cgi.csc.liv.ac.uk/~phil/Teaching/COMP327/artwork_images/" + results[artIndex].fileName!
            //Replaces spaces in the image URL to the appropriate characters
            let newImgURLString = imgURLString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            if let url = URL(string: newImgURLString!) {
                imgArt.contentMode = .scaleAspectFit
                downloadImage(url: url)
            }
            
            
        } catch let coreErr {
            print("Error with core data", coreErr)
        }
    }

    //Gets the iamge data from the URL
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    //Downloads the image
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.imgArt.image = UIImage(data: data)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
