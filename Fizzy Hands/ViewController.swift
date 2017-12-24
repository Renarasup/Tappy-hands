//
//  ViewController.swift
//  Fizzy Hands
//
//  Created by Sai on 09/07/17.
//  Copyright © 2017 Sai. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, GADBannerViewDelegate {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var adBanner: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label1.layer.cornerRadius=5.0;
        button.layer.cornerRadius=5.0;
        
        adBanner.isHidden=true;
        adBanner.delegate=self
        
        adBanner.adUnitID="ca-app-pub-1744189786640561/8972445931"
        adBanner.adSize=kGADAdSizeSmartBannerPortrait
        adBanner.rootViewController=self
        adBanner.load(GADRequest())
        
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        adBanner.isHidden=false
        
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        adBanner.isHidden=true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults=Foundation.UserDefaults.standard
        let value=userDefaults.string(forKey: "key")
        if(value==nil){
            label2.text="0"
        }else{
            label2.text=value
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

