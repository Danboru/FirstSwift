//
//  ViewController.swift
//  Jogja Organic
//
//  Created by Dan Bo on 7/24/17.
//  Copyright © 2017 com.eightstudio.www. All rights reserved.
//

import UIKit
import SystemConfiguration

class JogjaOrganic: UIViewController {
    
    //ButtonView
    @IBOutlet weak var buttonBackJogjaOrganic: UIButton!
    @IBOutlet weak var buttonForwardJogjaOrganic: UIButton!
    
    //ImageView
    @IBOutlet weak var internetImagesJogjaOrganic: UIImageView!

    //LabelView
    @IBOutlet weak var jogajaOrganicLabelConnection: UILabel!
    
    //UIWebView
    @IBOutlet weak var myWorldWebView: UIWebView!
    
    //UIButton
    @IBOutlet weak var buttonGotoSetting: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UILabel
        jogajaOrganicLabelConnection.center = self.view.center
        self.view.addSubview(jogajaOrganicLabelConnection)
        
        if connectedToNetwork() == true {//Ada koneksi
            
            jogajaOrganicLabelConnection.isHidden = true
            
            // Do any additional setup after loading the view, typically from a nib.
            let url = NSURL (string: "http://www.jogjaorganik.com/");
            let requestObj = NSURLRequest(url: url! as URL);
            myWorldWebView.loadRequest(requestObj as URLRequest);
            
            self.buttonGotoSetting.isHidden = true //Hide Button
            
        } else {//Tidak ada koneksi
            
            //Bold
            jogajaOrganicLabelConnection.font = UIFont.boldSystemFont(ofSize: jogajaOrganicLabelConnection.font.pointSize)
            jogajaOrganicLabelConnection.isHidden = false
            self.buttonBackJogjaOrganic.isHidden = true
            self.buttonForwardJogjaOrganic.isHidden = true
            self.buttonGotoSetting.isHidden = false
            
            //Color
            view.backgroundColor = .black
        }
    }

    //Stub function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Fungsi Button Back
    @IBAction func jogjaOrganicBack(_ sender: Any) {
        myWorldWebView.goBack()
    }
 
    //Fungsi Button Forward
    @IBAction func jogjaOrganicForward(_ sender: Any) {
        myWorldWebView.goForward()
    }
    
    //Acton button buttonGotoSetting
    @IBAction func gotoSetting(_ sender: UIButton) {
        
        //Object Alert Controller
        let alertController = UIAlertController (title: "Title", message: "Go to Settings?", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            //Jika alert dialog menereima string location yang di tuju
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        
        //let settingsAction = UIAlertAction(title: "Setting", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        //Menambahkan Action
        alertController.addAction(cancelAction)
        //alertController.addAction(settingsAction)
        alertController.addAction(settingsAction)
        
        //Menampilkan alert yang sudah di addAction
        present(alertController, animated: true, completion: nil)
        
    }
    
    //Fungsi untuk cek koneksi internet, jika true = tidak ada internet, jika false = ada internet
    func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        //Harus true dan true = true
        return (isReachable && !needsConnection)//Mengembalikan data
    }
    
}
