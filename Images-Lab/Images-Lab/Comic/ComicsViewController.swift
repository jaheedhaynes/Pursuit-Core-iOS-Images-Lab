//
//  ViewController.swift
//  Images-Lab
//
//  Created by Jaheed Haynes on 12/9/19.
//  Copyright © 2019 Jaheed Haynes. All rights reserved.
//

import UIKit

class ComicsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var textField: UITextField!
    
    var comics = [Comic]()
    
    var comicDayNum: Double = 600 {
        didSet{
            print("value: \(stepper.value)")
        }
    }
 
//---------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStepper()
        loadComic(comicDay: Int(stepper.value))
    }
    
//---------------------------------------------------------

    func loadComic(comicDay:Int){
        ComicAPIClient.getComic(for: comicDay) { (result) in
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let comic):
                DispatchQueue.main.async {
                    self.textField.text = comic.num.description
                    print(comic.img)
                    self.loadComicImage(comicImage: comic.img)
                    self.stepper.value = Double(comic.num)
                }
            }
        }
    }
    
    func loadComicImage(comicImage: String){
        NetworkHelper.shared.performDataTask(with: comicImage) { (result) in
            switch result{
            case .failure(let appError):
                print(appError)
            case .success(let data):
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    
    func configureStepper(){
        stepper.minimumValue = Double(comics.first?.num ?? 1)
        stepper.maximumValue = Double(comics.last?.num ?? 614)
        stepper.stepValue = 1.0
        stepper.value = Double(comics.first?.num ?? 1)
    }
    
//---------------------------------------------------------

    
    @IBAction func stepperClicked(_ sender: UIStepper) {
        loadComic(comicDay: Int(sender.value))
    }
    
    @IBAction func mostRecentButtonClicked(_ sender: UIButton) {
        loadComic(comicDay: Int(stepper.maximumValue))
    }
    
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        var arrayOfNum = [Int]()
        for comic in comics {
            arrayOfNum.append(comic.num)
        }
        
        let randomComic = Double.random(in: stepper.minimumValue...stepper.maximumValue)
        
        loadComic(comicDay: Int(randomComic))
    }
    
}
