//
//  ViewController.swift
//  JsonActors
//
//  Created by Karan Arora on 08/01/18.
//  Copyright © 2018 Karan Arora. All rights reserved.
//

import UIKit

struct actors:Decodable {
    let actors: [actor]
}
struct actor: Decodable {
    
    let name: String
    let description: String
    let dob: String
    let country: String
    let height: String
    let spouse: String
    let children: String
    let image: String

}
//image extention to download images
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    
    @IBOutlet weak var TableVieww: UITableView!
    var ac: actors?
    var bc: actor?
    var count: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        TableVieww.dataSource = self
        TableVieww.delegate = self
        downloadIt {
            self.count = ((self.ac?.actors.count)!)
            self.TableVieww.reloadData()
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Download data through json api
    func downloadIt(completed: @escaping ()->()){
        let url1 = URL(string: "http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors")
        URLSession.shared.dataTask(with: url1!) { (data, response, error) in
            if error == nil{
                do{
                    self.ac = try JSONDecoder().decode(actors.self, from: data!)
                    DispatchQueue.main.async {
                    
                        completed()
                    }
                }catch{
                    print("Json Error")
                }
            }else{
                print("error")
            }
            
        }.resume()
        
        
        
        
    }
    
    // to return no of rows in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    // to add data in tableview cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = UITableViewCell(style: .default, reuseIdentifier:"celll" )
      //  let cell = TableVieww.dequeueReusableCell(withIdentifier: "customCell")
        cell.textLabel?.text = self.ac?.actors[indexPath.row].name
        let ul = URL(string: (self.ac?.actors[indexPath.row].image)!)
        cell.imageView?.downloadedFrom(url: ul!)
        //  cell.imageView?.downloadedFrom(link: (self.ac?.actors[indexPath.row].image)!)
        
        return cell
    }
    
    // action on clicking cell in tableview
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  performSegue(withIdentifier: "customCell", sender: self)
        print("You tapped cell number \(indexPath.row).")
        performSegue(withIdentifier: "cel", sender: self)

    }

    // pass data through segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DiscriptionViewController{
            destination.abc = ac?.actors[(TableVieww.indexPathForSelectedRow?.row)!]
            
        }
    }
    
    
    
}

