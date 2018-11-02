//
//  ViewController.swift
//  Assignment 2
//
//  Created by Jonathan Nates on 29/11/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//

import UIKit
import CoreData
import MapKit

//Structures used to read from the JSON file
struct Artworks: Decodable {
    let artworks2: [Art]
}

struct Art: Decodable {
    let id: String
    let title: String
    let artist: String
    let yearOfWork: String?
    let Information: String?
    let lat: String
    let long: String
    let location: String
    let locationNotes: String?
    let fileName: String?
    let lastModified: String?
    let enabled: String
}

//Variable used to determine if the app has been launched or not
var launched = false

class ViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    //Array that stores all the names of buildings from core data
    var arrBuildings: [String] = []
    var locationManager = CLLocationManager()
    
    // Function that populates the artwork in the table view cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "myCell")
        
        let fetchRequest: NSFetchRequest<Artwork> = Artwork.fetchRequest()
        do
        {
            //Sorts core data based on distance from current location
            let sortDescriptor = NSSortDescriptor(key: "distance", ascending: true)
            let sortDescriptors = [sortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
            //Filters core data with records that have the same building location
            fetchRequest.predicate = NSPredicate(format: "location MATCHES[cd] '(\(arrBuildings[indexPath.section])).*'")
            
            
            let fetchResults = try PersistenceService.context.fetch(fetchRequest)
            let results = fetchResults as [Artwork] //Core Data
            
            //Displays the artwork name and the distance of the artwork from the user
            cell.textLabel?.text = results[indexPath.row].title!
            cell.detailTextLabel?.text = "Distance: \(Int(results[indexPath.row].distance))m"
            
            
        } catch let coreErr {
            print("Error with core data", coreErr)
        }
        
        return cell
    }
    
    // Function that sets the number of artwork in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fetchRequest: NSFetchRequest<Artwork> = Artwork.fetchRequest()
        var secNum = 0
        do
        {
            //Sorts core data based on distance from current location
            let sortDescriptor = NSSortDescriptor(key: "distance", ascending: true)
            let sortDescriptors = [sortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
            //Filters core data with records that have the same building location
            fetchRequest.predicate = NSPredicate(format: "location MATCHES[cd] '(\(arrBuildings[section])).*'")
            
            
            let fetchResults = try PersistenceService.context.fetch(fetchRequest)
            let results = fetchResults as [Artwork] //Core Data
            // The number of artwork in each section
            secNum = results.count
        } catch let coreErr {
            print("Error with core data", coreErr)
        }
        return secNum
    }
    
    // The number of buildings in core data (This is used for sections)
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrBuildings.count
    }
    
    // The title of each section (building name)
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrBuildings[section]
    }
    
    // Function responsible for dealing with when the user selects and artwork in the table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ArtworkView") as! ArtworkView
        let currentCell = tableView.cellForRow(at: indexPath) as UITableViewCell!
        //Passes the art title into the artwork view
        newViewController.artTitle = currentCell!.textLabel!.text!
        self.present(newViewController, animated: true, completion: nil)
    }
    

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Checks if this is the first time the program is launched
        // If this is the first launch it will setup the core data from the json
        if (launched == false)
        {
            setupJsonCore()
            launched = true
        }
        //If the program has already been launche then the array will be setup for the use of the map,etc
        else
        {
            setupArray()
        }
        
        //Dealing with location of the user
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        myTable.reloadData()
        
        
    }
    
    //Code provided by Phill to deal with user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: location, span: span)
        self.map.setRegion(region, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /* This function is responsible for setting up core data from JSON
     * It reads in the JSON file and then compares to see if core data has any information in it
     * If there is no information then all info in JSON will be transfered over into core data
     * If info is already stored into core data then all info in core data will be compared to info in the JSON file to make sure there are no updates
     * If there are updates in the JSON file they will be added to core data
     */
    func setupJsonCore()
    {
        let jsonString = "https://cgi.csc.liv.ac.uk/~phil/Teaching/COMP327/artworksOnCampus/data.php?class=artworks2&lastUpdate=2017-11-01"
        guard let url = URL(string: jsonString) else { return }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do
            {
                let art = try JSONDecoder().decode(Artworks.self, from: data) //JSON
                
                let fetchRequest: NSFetchRequest<Artwork> = Artwork.fetchRequest()
                do
                {
                    let fetchResults = try PersistenceService.context.fetch(fetchRequest)
                    let results = fetchResults as [Artwork] //Core Data
                    
                    //Checks if there is any information in core data
                    //If not then transfers all data from JSON into core data
                    if results.count == 0
                    {
                        let jsonLoop = Int(art.artworks2.count) - 1
                        for index in 0...jsonLoop
                        {
                            //print(art.artworks2[index].title)
                            let id = art.artworks2[index].id
                            let title = art.artworks2[index].title
                            let artist = art.artworks2[index].artist
                            let yearOfWork = art.artworks2[index].yearOfWork ?? "0000"
                            let information = art.artworks2[index].Information ?? ""
                            let lat = Double(art.artworks2[index].lat)
                            let long = Double(art.artworks2[index].long)
                            let location = art.artworks2[index].location
                            let locationNotes = art.artworks2[index].locationNotes ?? ""
                            let fileName = art.artworks2[index].fileName ?? ""
                            let lastModified = art.artworks2[index].lastModified ?? ""
                        
                            //Calculates the distance from the artwork to the users location
                            let currentCoordinate = CLLocation(latitude: 53.406566, longitude: -2.966531)
                            let artCoordinate = CLLocation(latitude: lat!, longitude: long!)
                            let distance = Double(currentCoordinate.distance(from: artCoordinate))
                            
                            //Calls a function from the saving class to deal with saving all infromation into core data
                            Saving().saveToCore(id: id, title: title, artist: artist, yearOfWork: yearOfWork, information: information, lat: lat!, long: long!, location: location, locationNotes: locationNotes, fileName: fileName, lastModified: lastModified, distance: distance)
                        }
                    }
                    //If there is information in core data then all records in core data are compared to the records in JSON
                    //This ensures that all artworks are present in core data
                    else
                    {
                        let coreLoop = Int(results.count) - 1
                        let jsonLoop = Int(art.artworks2.count) - 1
                        for index in 0...jsonLoop
                        {
                            var found = false
                            for j in 0...coreLoop
                            {
                                //Checks to see if an artwork is found
                                if Int(art.artworks2[index].id) == Int(results[j].id)
                                {
                                    found = true
                                    //If the artwork is found but enabled in JSON is set to 0 then the artwork will be deleted from core data
                                    if (Int(art.artworks2[index].enabled) == 0)
                                    {
                                        PersistenceService.context.delete(results[j])
                                    }
                                    break
                                }
                                
                            }
                            //If the artwork is not found then it will be added to core data
                            if found == false
                            {
                                //print(art.artworks2[index].title)
                                let id = art.artworks2[index].id
                                let title = art.artworks2[index].title
                                let artist = art.artworks2[index].artist
                                let yearOfWork = art.artworks2[index].yearOfWork ?? "0000"
                                let information = art.artworks2[index].Information ?? ""
                                let lat = Double(art.artworks2[index].lat)
                                let long = Double(art.artworks2[index].long)
                                let location = art.artworks2[index].location
                                let locationNotes = art.artworks2[index].locationNotes ?? ""
                                let fileName = art.artworks2[index].fileName ?? ""
                                let lastModified = art.artworks2[index].lastModified ?? ""
                                
                                
                                let currentCoordinate = CLLocation(latitude: 53.406566, longitude: -2.966531)
                                let artCoordinate = CLLocation(latitude: lat!, longitude: long!)
                                let distance = Double(currentCoordinate.distance(from: artCoordinate))
                                
                                Saving().saveToCore(id: id, title: title, artist: artist, yearOfWork: yearOfWork, information: information, lat: lat!, long: long!, location: location, locationNotes: locationNotes, fileName: fileName, lastModified: lastModified, distance: distance)
                            }
                        }
                    }
                } catch let coreErr {
                    print("Error with core data", coreErr)
                }
                
            } catch  let jsonErr {
                print("Error serialising json", jsonErr)
            }
            //Once all the setup is complete this ensures that the array of buildings is setup
            DispatchQueue.main.async {
                self.setupArray()
            }
            }.resume()
    }
    
    // Function responsible for setting up the annotaions on the map and clusting artwork together
    func setupMap()
    {
        let fetchRequest: NSFetchRequest<Artwork> = Artwork.fetchRequest()
        
        do
        {
            //Sorts artwork by distance from location
            let sortDescriptor = NSSortDescriptor(key: "distance", ascending: true)
            let sortDescriptors = [sortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
            //Placing annotations of the artwork
            let buildCount = self.arrBuildings.count - 1
            //print(buildCount)
            for index in 0...buildCount
            {
                //Filters the core data by artwork inside the current building
                fetchRequest.predicate = NSPredicate(format: "location MATCHES[cd] '(\(arrBuildings[index])).*'")
                let fetchResults = try PersistenceService.context.fetch(fetchRequest)
                let results = fetchResults as [Artwork] //Core Data
                let artCount = results.count - 1
                
                //If a building only has 1 artwork the annotation of the artwork will be displayed
                if (results.count == 1)
                {
                    print("added one")
                    let location = CLLocationCoordinate2D(latitude: results[0].lat, longitude: results[0].long)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = results[0].title
                    annotation.subtitle = "By: \(results[0].artist!)"
                    self.map.addAnnotation(annotation)
                }
                /* If the building has more than one artwork this code will run
                 * The average distance between art is calculated and then if artwork falls within 20m of the average
                 * the artwork will fall under the building annotation.
                 * If the artwork is above 20m away from the average the artwork will be a seperate annoation
                 */
                else
                {
                    //Works out the average distance between artworks in the building
                    var distance = 0
                    for j in 0...artCount
                    {
                         distance = distance + Int(results[j].distance)
                    }
                    let averageDist = distance / (artCount + 1)
                    
                    var placed = false
                    for artIndex in 0...artCount
                    {
                        //Places an annotation for the building location
                        if ((Int(results[artIndex].distance) <= (averageDist + 20)) && (Int(results[artIndex].distance) >= (averageDist - 20)) && (placed == false))
                        {
                            print("print building")
                            let location = CLLocationCoordinate2D(latitude: results[artIndex].lat, longitude: results[artIndex].long)
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = location
                            annotation.title = results[artIndex].location
                            self.map.addAnnotation(annotation)
                            placed = true
                        }
                        //Places an annotation for individual artwork if it falls outside the average distance of the building
                        else if ((Int(results[artIndex].distance) > (averageDist + 20)) || (Int(results[artIndex].distance) < (averageDist - 20)))
                        {
                            print("building- single annotation")
                            let location = CLLocationCoordinate2D(latitude: results[artIndex].lat, longitude: results[artIndex].long)
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = location
                            annotation.title = results[artIndex].title
                            annotation.subtitle = "By: \(results[artIndex].artist!)"
                            self.map.addAnnotation(annotation)
                        }
                    }
                }
            }
            
        } catch let coreErr {
            print("Error with core data", coreErr)
        }
        DispatchQueue.main.async {
            self.myTable.reloadData()
        }
    }
    
    //Function responsible for filling the array with all the building names
    func setupArray()
    {
        let fetchRequest: NSFetchRequest<Artwork> = Artwork.fetchRequest()
        
        do
        {
            //Sorts artwork by distance from location
            let sortDescriptor = NSSortDescriptor(key: "distance", ascending: true)
            let sortDescriptors = [sortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
            let fetchResults = try PersistenceService.context.fetch(fetchRequest)
            let results = fetchResults as [Artwork] //Core Data
            
            //Goes through all records in core data
            for index in results
            {
                //Used to populate the array with all the building names
                var found = false
                //The first record in core data will always be the first building name so it automatically is added to the array
                if (self.arrBuildings.count == 0)
                {
                    self.arrBuildings.append(index.location!)
                }
                else
                {
                    let loop = self.arrBuildings.count - 1
                    //Checks to see if the building name is already in the array
                    for i in 0...loop
                    {
                        if (index.location == self.arrBuildings[i])
                        {
                            found = true
                        }
                    }
                    //If the building name is not in the array it will be added
                    if (found == false)
                    {
                        self.arrBuildings.append(index.location!)
                        
                    }
                }
            }
        } catch let coreErr {
            print("Error with core data", coreErr)
        }
        //Once the array is created then it calls the setup map function
        DispatchQueue.main.async {
            //print(self.arrBuildings.count)
            self.setupMap()
            self.myTable.reloadData()
        }
        
    }
    
    //Sets up annotations so that when they're clicked they display information about the artwork and a clickable "info" button
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        let identifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .infoLight)
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    /* When the annotation information mark is clicked this function will deal with that and trasnfer the user to the appropraite view
     * If a building annotation is clicked then the building view will be displayed in the building view
     * If an artwork annotation is clicked then the specific artwork will be displayed in the artwork view
     */
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let title = view.annotation!.title!
        var found = false
        let buildCount = self.arrBuildings.count - 1
        //Checks to see if the title of the annotation is a building
        for index in 0...buildCount
        {
            if (title! == arrBuildings[index])
            {
                found = true
                break
            }
        }
        
        //If the selected annotation is a building the view switches to the building view
        if (found == true)
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "BuildingView") as! BuildingView
            newViewController.buildName = title!
            self.present(newViewController, animated: true, completion: nil)
        }
        //If the selected annotation is an artwork the view switches to the artwork view
        else
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ArtworkView") as! ArtworkView
            newViewController.artTitle = title!
            self.present(newViewController, animated: true, completion: nil)
        }
    
    }
}



