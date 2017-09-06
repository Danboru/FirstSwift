//
//  SportControllerViewController.swift
//  Jogja Organic
//
//  Created by Dan Bo on 8/14/17.
//  Copyright © 2017 com.eightstudio.www. All rights reserved.
//

import UIKit
import SystemConfiguration

class BerduResi: UIViewController {

    //ButtonView
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonForward: UIButton!
    
    //ImageView
    @IBOutlet weak var internetImage: UIImageView!
    
    //LabelView
    @IBOutlet weak var connectionStatusBerdu: UILabel!
    
    //UIWebView
    @IBOutlet weak var mySportWebView: UIWebView!
    
    //UIButton
    @IBOutlet weak var buttonGotoSetting: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        connectionStatusBerdu.center = self.view.center
        self.view.addSubview(connectionStatusBerdu)

        
        if connectedToNetwork() == true {
           
            connectionStatusBerdu.isHidden = true
            // Do any additional setup after loading the view, typically from a nib.
            let url = NSURL (string: "https://berdu.id/cek-resi");
            let requestObj = NSURLRequest(url: url! as URL);
            mySportWebView.loadRequest(requestObj as URLRequest);
            self.buttonGotoSetting.isHidden = true
            
        } else {
            //Bold
            connectionStatusBerdu.font = UIFont.boldSystemFont(ofSize: connectionStatusBerdu.font.pointSize)
            connectionStatusBerdu.isHidden = false
            self.buttonBack.isHidden = true
            self.buttonForward.isHidden = true
            self.buttonGotoSetting.isHidden = false
            
            //Color
            view.backgroundColor = .black
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //Fungsi Button Back
    @IBAction func berduBack(_ sender: Any) {
        mySportWebView.goBack()
    }
    
    //Fungsi Button Forward
    @IBAction func berduForward(_ sender: Any) {
        mySportWebView.goForward()
    }
    
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
