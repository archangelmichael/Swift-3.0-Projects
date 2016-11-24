//
//  ViewController.swift
//  Places
//
//  Created by Radi on 11/24/16.
//  Copyright © 2016 Oryx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var cities = ["Sofia", "Plovdiv", "Varna", "Targovishte", "Velingrad","Burgas","Popovo","Karlovo","Pavel Banya", "Trustenik","Isperikh","Shumen","Orlovets","Dobrich","Gabrovo","Haskovo","Provadiya","Kharmanli","Sliven","Stara Zagora","Kozloduy","Shabla","Kavarna","Sevlievo","Lovech","Gorna Oryakhovitsa","Blagoevgrad","Petrich","Krumovgrad","Krichim","Smolyan","Radnevo","Muglizh","Troyan","Veliko Tarnovo","Nikopol","Kazanlak","Chakalarovo","Pernik","Ruen","Barutin","Bratsigovo","Isperikhovo","Godech","Chernolik","Razgrad","Dulovo","Yambol","Asenovgrad","Pazardzhik","Chirpan","Rozino","Ravda","Montana","General-Toshevo","Aksakovo","Baltchik","Rodopi","Ikhtiman","Samokov","Svoge","Sopot","Kardzhali","Pleven","Kyustendil","Topoli","Beloslav","Dulgopol","Obzor","Cherven","Vratsa","Borovan","Knezha","Cherven Bryag","Sandanski","Dupnitsa","Lozno","Krupnik","Boboshevo","Rousse","Sandrovo","Zavet","Svishtov","Belene","Pavlikeni","Samovodene","Polski Trumbesh", "Kostievo", "Akhtopol", "Nesebar", "Sredets", "Pomorie", "Simitli", "Slivnitsa","Mezdra","Batak","Elkhovo","Belogradchik","Tutrakan","Botevgrad","Moderno Predgradie","Borovo","Topolovo","Bankya","Konush","Dimitrovgrad","Smyadovo","Gulubovo","Simeonovgrad","Panagyurishte","Bansko","Yakoruda","Silistra","Byala","Choba","Iskrets","Vlado Trichkov","Zlatitrap","Nova Zagora","Devin","Gotse Delchev","Dragizhevo","Byala","Momchilgrad","Pravets","Etropole","Malo Konare","Aytos","Bukovo","Banite","Chiprovtsi","Mesta","Tryavna","Berkovitsa","Novi Pazar","Krivodol","Elena","Strazhitsa","Peshtera","Sozopol","Moravka","Kovachite","Omurtag","Vidin","Kostinbrod","Ardino","Alfatar","Rakovski","Poleto","Rila","Draginovo","Oryakhovitsa","Dolna Oryakhovitsa","Kostenets","Raduil","Bukovo","Strelcha","Sokolets","Skravena","Vrachesh","Stamboliyski","Lom","Bistritsa","Khisarya","Shivachevo","Anton","Madan","Elin Pelin","Veliko","Debelets","Oryakhovets","Markovo","Bregare","Byala Slatina","Sofronievo","Kula","Lyulyakovo","Kableshkovo","Antonovo","Belovo","Dospat","Dolna Banya","Septemvri","Bobovdol","Zlatograd","Tervel","Lyaskovets","Mikrevo","Vievo","Chernomorets","Kran","Karnobat","Dryanovo","Ovoshtnik","Koprivets","Vetren","Lukovit","Babovo","Kamenovo","Orizovo","Svilengrad","Rudozem","Aleksandriya","Rakitovo","Ivaylovgrad","Glogovo","Gurkovo","Marikostinovo","Tochilari","Slatina","Razlog","Prespa","Gurmazovo","Novi Iskur","Samuil","Pchelishte","Dragash Voyvoda","Dolna Mitropoliya","Koprivlen","Suedinenie","Kazashka Reka","Ganchovo"];
    
    var citiesData : Dictionary<String, Dictionary<String, Double>> = [:];
    var counter = 20;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //self.getLocation(byCity: cities[0]);
        
        for cityName in cities {
            self.getLocation(byCity: cityName);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getLocation(byCity name: String) -> Void {
        let urlStr = "https://maps.googleapis.com/maps/api/geocode/json?address=\(name)"
        if let url = URL(string: urlStr) {
            let request = NSMutableURLRequest(url: url)
            let session = URLSession.shared
            request.httpMethod = "GET"
        
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request as URLRequest,
                                        completionHandler:
                { (data, response, error) in
                    self.counter += 1
                    
                    if error != nil {
                        print(error!)
                    }
                    else {
                        do {
                        
                            let datastring = NSString(data: data!,
                                                      encoding: String.Encoding.utf8.rawValue)
                            let data2: Data = (datastring?.data(using: String.Encoding.utf8.rawValue))!
                            let json = try JSONSerialization.jsonObject(with: data2,
                                                                         options: .allowFragments) as! [String : AnyObject]
                            //print(json["results"]![0] as? [String: AnyObject])
                            if let results = json["results"] as? Array<Dictionary<String, AnyObject>> {
                                if results.count > 0 {
                                    if let geometry = results[0]["geometry"] as? Dictionary<String, Any> {
                                        if let location = geometry["location"] as? Dictionary<String, Double> {
                                            let latitude = location["lat"]!
                                            let longitude = location["lng"]!
                                            
                                            // print("\(latitude) \(longitude)")
                                            
                                            self.citiesData[name]  = [
                                                "lat" : latitude,
                                                "lon" : longitude
                                            ]
                                        }
                                    }
                                }
                            }
                            
                            
                        }
                        catch let error as NSError {
                            print(error)
                        }
                    }
                    
                    if self.counter == self.cities.count {
                        print(self.citiesData)
                    }
            })
            
            task.resume()
        }
        
        
       
    }
}

