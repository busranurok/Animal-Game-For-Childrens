//
//  ViewController.swift
//  AnimalGameForChildrenApp
//
//  Created by Yeni Kullanıcı on 29.07.2020.
//  Copyright © 2020 Busra Nur OK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var catLabel: UILabel!
    @IBOutlet weak var dogLabel: UILabel!
    @IBOutlet weak var birdLabel: UILabel!
    
    var animalsName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func catClicked(_ sender: Any) {
        animalsName = catLabel.text!
        performSegue(withIdentifier: "toSecondVC", sender: nil)
    }
    
    
    @IBAction func dogClicked(_ sender: Any) {
        //sender: diğer tarafa bilgi yollamak için
        //butona tıklanmdığında bu segue gerçekleşti ve identity de bu diyoruz
        animalsName = dogLabel.text!
        performSegue(withIdentifier: "toSecondVC", sender: nil)
    }
    
    
    @IBAction func birdClicked(_ sender: Any) {
        animalsName = birdLabel.text!
        performSegue(withIdentifier: "toSecondVC", sender: nil)
    }
    
    //segue olmadan hemen önceki yapılacak işlemleri burada yapar
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //her zaman segue nin identifier ını kontrol ederek başlamalısın
        //gittiğin yerdeki viewcontroler ı al ve oradaki animalname i değiştir
        if segue.identifier == "toSecondVC" {
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.animalName = animalsName
        }
    }
}

