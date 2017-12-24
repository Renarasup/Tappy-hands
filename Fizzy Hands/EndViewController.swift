//
//  EndViewController.swift
//  Fizzy Hands
//
//  Created by Sai on 12/07/17.
//  Copyright © 2017 Sai. All rights reserved.
//

import UIKit
import Social
import MessageUI
import GoogleMobileAds

class EndViewController: UIViewController,MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, GADBannerViewDelegate {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var adBanner: GADBannerView!
    
    
    var scoreData:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scoreLabel.text=scoreData
        
        label1.layer.cornerRadius=5.0
        label2.layer.cornerRadius=5.0
        button1.layer.cornerRadius=5.0
        button2.layer.cornerRadius=5.0
        button3.layer.cornerRadius=5.0
        button4.layer.cornerRadius=5.0
        
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func restartGame(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        self.presentingViewController?.dismiss(animated: false, completion: nil)
        
        
    }
    
    @IBAction func shareTwitter(_ sender: Any) {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
            let twitter:SLComposeViewController=SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitter.setInitialText("My final score was \(scoreLabel.text!)")
            self.present(twitter, animated: true, completion: nil)
            
        }else{
            let alert=UIAlertController(title: "Accounts", message: "Please log into twitter account from within you settings", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    @IBAction func shareEmail(_ sender: Any) {
        
        if MFMailComposeViewController.canSendMail(){
            
            let mail:MFMailComposeViewController=MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(nil)
            mail.setSubject("I bet you can't beat me!")
            mail.setMessageBody("My final score was \(scoreLabel.text!)", isHTML: false)
            
            self.present(mail, animated: true, completion: nil)
            
        }else{
            
            let alert:UIAlertController=UIAlertController(title: "Accounts", message: "Please log into your email account", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
                    
            
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func shareSMS(_ sender: Any) {
        
        if MFMessageComposeViewController.canSendText(){
            let message:MFMessageComposeViewController=MFMessageComposeViewController()
            message.messageComposeDelegate=self
            message.recipients=nil
            message.body="My final score was \(scoreLabel.text!)"
            self.present(message, animated: true, completion: nil)
            
            
        }else{
            
            let alert:UIAlertController=UIAlertController(title: "Warning", message: "This device cannot send SMS", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
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
