//
//  ViewController.swift
//  TableStory
//
//  Created by Saathoff, Desarae C on 3/22/23.
//

import UIKit
import MapKit

let data = [
    Item(name: "Paws N Go", neighborhood: "On Campus", desc: "This location is a small store in the middle of central campus, only a 3-5 minute walk from almost any building on the lower half of campus. It also provides students with a variety of snacks and drinks to hydrate them.", lat: 29.888670034063338, long: -97.94132618952085, imageName: "pawsngo"),
    Item(name: "Taylor Murphy, Lounge Area", neighborhood: "On Campus", desc: "This location is one of the most peaceful outdoor spaces on campus. Due to the area, it is in most students don't know it, and that results in only history majors populating the area and a less busy crowd compared to the Library.", lat: 29.889428316860062, long: -97.94142525576362, imageName: "taylormurphy"),
    Item(name: "Centenial, Computer Lab", neighborhood: "On Campus", desc: "This location is students' dream with both Mac and Windows computers at their fingertips. They are open for anyone to use and are a great space to work on group projects together or print PowerPoint before your next class.", lat: 29.889725433994098, long: -97.94008669274625, imageName: "commlab"),
    Item(name: "LBJ, Starbucks", neighborhood: "On Campus", desc: "This location is good because it is in an area that most students pass through. Because of that, it is also on the lower levels of the building next to other restaurants, providing food and hydration.", lat: 29.889023309303575, long: -97.94310038948146, imageName: "lbjstarbucks"),
    Item(name: "Old Main, Computer Lab", neighborhood: "On Campus", desc: "This location is an amazing resource for Mass Comm students. With it being a rather private and hidden area, DMI majors tend to know of its existence resulting in it mostly having space to work on your newest project. ", lat: 29.8894068731851, long: -97.93893590941295, imageName: "dmilab")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
  
        
    @IBOutlet weak var theTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
  }


  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
      let item = data[indexPath.row]
      cell?.textLabel?.text = item.name
      let image = UIImage(named: item.imageName)
                    cell?.imageView?.image = image
                    cell?.imageView?.layer.cornerRadius = 10
                    cell?.imageView?.layer.borderWidth = 5
                    cell?.imageView?.layer.borderColor = UIColor.white.cgColor
      return cell!
  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    
  }
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "ShowDetailSegue" {
                  if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                      // Pass the selected item to the detail view controller
                      detailViewController.item = selectedItem
                  }
              }
          }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theTable.delegate = self
        theTable.dataSource = self
        
        //set center, zoom level and region of the map
                let coordinate = CLLocationCoordinate2D(latitude: 29.888587717310582, longitude: -97.9411404990729)
                let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                mapView.setRegion(region, animated: true)
                
             // loop through the items in the dataset and place them on the map
                 for item in data {
                    let annotation = MKPointAnnotation()
                    let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                    annotation.coordinate = eachCoordinate
                        annotation.title = item.name
                        mapView.addAnnotation(annotation)
                        }        // Do any additional setup after loading the view.
    }


}

