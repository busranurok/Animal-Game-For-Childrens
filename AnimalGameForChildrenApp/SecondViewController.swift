//
//  SecondViewController.swift
//  AnimalGameForChildrenApp
//
//  Created by Yeni Kullanıcı on 29.07.2020.
//  Copyright © 2020 Busra Nur OK. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var labelAnimalName: UILabel!
    
    //Variables
    var animalName = ""
    var score = 0
    var highScore = 0
    var timer = Timer()
    var timerCountDownCounter = 0
    var imageHiddenTimer = Timer()
    var imageArray = [UIImageView]()
    var urlArray : [String]!
    
    
    //Views
    @IBOutlet weak var timerCountDown: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelHighScore: UILabel!
    
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    
    //ViewDidload
    override func viewDidLoad() {
        super.viewDidLoad()

        //açıldığı gibi diğer sayfada label de yazılmasını burada gösteririz
        //build etmeliyiz ki burada oluşturduğumuz değişkeni diğer yerlerde de algılansın.
        labelAnimalName.text = "Animal of your choice  : \(animalName)"
        
        //HighScore check
        //highscore userdefault tan alırız
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        if storedHighScore == nil {
            highScore = 0
            labelHighScore.text = "HighScore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            labelHighScore.text = "HighScore: \(highScore)"
        }
        
        timerCountDownCounter = 30
        
        labelScore.text = "Score: \(score)"
        timerCountDown.text = "Time: \(timerCountDownCounter)"

        //Timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTime), userInfo: nil, repeats: true)
        imageHiddenTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hiddenImage), userInfo: nil, repeats: true)
        
        imageArray = [imageView1, imageView2, imageView3, imageView4, imageView5, imageView6, imageView7, imageView8, imageView9]
        
        
        /*for imageView in imageArray{
            //Kullanıcının bu imageview a tıklamasına imkan sağlarız
            imageView.isUserInteractionEnabled = true
        }*/
        
        
        for imageView in imageArray {
            //Kullanıcının bu imageview a tıklamasına imkan sağlarız
            imageView.isUserInteractionEnabled = true
            
            //çoklu dokunuşu sağlar. Dokundukça score yi arttırır
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
            imageView.addGestureRecognizer(recognizer)
        }
        
        // 0 = kedi, 1= köpek, 2=kuş
        urlArray = ["https://i1.wp.com/pawsomekitty.com/wp-content/uploads/Siamese-cat-names.png?resize=766%2C438&ssl=1", "https://s3.pixers.pics/pixers/160/FO/68/02/44/52/160_FO68024452_a98ba7ab65298494cd9a5290cf8317d5.jpg","https://www.kindpng.com/picc/m/89-893565_cockatiels-bird-pillow-cockatiel-bird-hd-png-download.png"]
        
        
        for imageView in imageArray {
            
            if  animalName == "Cat" {
                let url = URL(string: urlArray[0])
                let data = try? Data(contentsOf: url!)
                imageView.image = UIImage(data: data!)
          
                //içeriye resim atıp oradan almak ister isek
                /*imageView.image = UIImage(named: "cat")
                imageView.image=#imageLiteral(resourceName: "cat")*/
                
            } else if animalName == "Dog"{
                let url = URL(string: urlArray[1])
                let data = try? Data(contentsOf: url!)
                imageView.image = UIImage(data: data!)
                
                /*imageView.image = UIImage(named: "dog")
                imageView.image=#imageLiteral(resourceName: "dog")*/
                
            } else if animalName == "Bird"{
                /*imageView.image = UIImage(named: "bird")
                imageView.image = #imageLiteral(resourceName: "bird")*/
                
                let url = URL(string: urlArray[2])
                let data = try? Data(contentsOf: url!)
                imageView.image = UIImage(data: data!)
            }
            
        }
        
        hiddenImage()
    }
    
    //zamanı azaltma
    @objc func decreaseTime(){
        timerCountDownCounter -= 1
        timerCountDown.text = String(timerCountDownCounter)
        
        
        if timerCountDownCounter == 0 {
            timer.invalidate()
            imageHiddenTimer.invalidate()
            
            //oyun bittikten sonra resmin görünmesini istemiyorsam
            for imageView in imageArray{
                imageView.isHidden = true
            }
    
       highScoreFunc()
        
        //Alert
        let alert = UIAlertController(title: "Time' s Up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton=UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //replay function
                self.score = 0
                self.labelScore.text = "Score: \(self.score)"
                
                self.timerCountDownCounter = 30
                self.labelScore.text = "Time: \(self.decreaseTime())"
                
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.decreaseTime), userInfo: nil, repeats: true)
                self.imageHiddenTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hiddenImage), userInfo: nil, repeats: true)
            }
            
            
        
        alert.addAction(okButton)
        alert.addAction(replayButton)
        self.present(alert, animated: true, completion: nil)
        
        }
    }
    
    //ilk açıldığında resimleri saklama
     @objc func hiddenImage(){
        for imageView in imageArray {
            imageView.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(imageArray.count - 1)))
        imageArray[random].isHidden = false
        
    }
    
    
    //Score arttırma
    @objc func increaseScore(){
        score += 1
        labelScore.text = "Score: " + String(score)
    }
    
    
    @objc func highScoreFunc(){
        if score > highScore {
            highScore = score
            
           
            labelHighScore.text = "High Score: \(highScore)"
            //highscore userdefault a kaydediyoruz
            UserDefaults.standard.set(self.highScore, forKey: "highScore")
            
          
        }else{
            self.score = self.highScore
        }
        
    }

}

