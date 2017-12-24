//
//  GameViewController.swift
//  Fizzy Hands
//
//  Created by Sai on 09/07/17.
//  Copyright © 2017 Sai. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GameViewController: UIViewController, GADBannerViewDelegate {



    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var timeRemaining: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var adBanner: GADBannerView!
    
    
    var tapInt=0
    
    var startInt=3
    var startTimer=Timer()

    var gameInt=10
    var gameTimer=Timer()
    
    var recordData:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapInt=0
        scoreLabel.text=String(tapInt)
        
        time.layer.cornerRadius=5.0
        score.layer.cornerRadius=5.0
        button.layer.cornerRadius=5.0
        
        startInt=3
        button.setTitle(String(startInt), for: .normal)
        button.isEnabled=false

        startTimer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.startGameTimer), userInfo: nil, repeats: true)
        
        let userDefaults=Foundation.UserDefaults.standard
        let value=userDefaults.string(forKey: "key")
        recordData=value

        
        adBanner.isHidden=true;
        adBanner.delegate=self
        
        adBanner.adUnitID="ca-app-pub-1744189786640561/8972445931"
        adBanner.adSize=kGADAdSizeSmartBannerPortrait
        adBanner.rootViewController=self
        adBanner.load(GADRequest())
        
        
        // Do any additional setup after loading the view.
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        adBanner.isHidden=false
        
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        adBanner.isHidden=true
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
    
    @IBAction func tapMeButton(_ sender: UIButton) {
        tapInt+=1
        scoreLabel.text=String(tapInt)
    }
    
    func startGameTimer(){
        startInt-=1
        button.setTitle(String(startInt), for: .normal)
        if(startInt==0){
            startTimer.invalidate()
            button.setTitle("Tap me", for: .normal)
            button.isEnabled=true
            
            gameInt=10
            timeRemaining.text=String(gameInt)
            gameTimer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.game), userInfo: nil, repeats: true)
        }
    }
    
    func game(){
        gameInt-=1
        timeRemaining.text=String(gameInt)
        if gameInt==0{
            button.isEnabled=false
            gameTimer.invalidate()
            
            if(recordData==nil){
                let savedString=scoreLabel.text
                let userDefaults=Foundation.UserDefaults.standard
                userDefaults.set(savedString, forKey: "key")
            }else{
                let score:Int?=Int(scoreLabel.text!)
                let record:Int?=Int(recordData)
                if score! > record! {
                    let savedString=scoreLabel.text
                    let userDefaults=Foundation.UserDefaults.standard
                    userDefaults.set(savedString, forKey: "key")
                }
            }
            
            
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.end), userInfo: nil, repeats: false)
        }
        
    }

    func end(){
        
        if UIDevice.current.userInterfaceIdiom == .phone {
    
            let vc=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "endGame") as! EndViewController
            vc.scoreData=scoreLabel.text
            
            self.present(vc, animated: false, completion: nil)
            
        } else if UIDevice.current.userInterfaceIdiom == .pad {
        
            let vc=UIStoryboard(name: "iPadStoryboard", bundle: nil).instantiateViewController(withIdentifier: "endGame") as! EndViewController
            vc.scoreData=scoreLabel.text
            
            self.present(vc, animated: false, completion: nil)
            
        }
        
        
    }
    
}
