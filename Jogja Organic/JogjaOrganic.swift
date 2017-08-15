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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        jogajaOrganicLabelConnection.center = self.view.center
        self.view.addSubview(jogajaOrganicLabelConnection)
        
        if connectedToNetwork() == true {
            internetImagesJogjaOrganic.isHidden = true
            jogajaOrganicLabelConnection.isHidden = true
            
            // Do any additional setup after loading the view, typically from a nib.
            let url = NSURL (string: "http://www.jogjaorganik.com/");
            let requestObj = NSURLRequest(url: url! as URL);
            myWorldWebView.loadRequest(requestObj as URLRequest);
        } else {
            //Bold
            jogajaOrganicLabelConnection.font = UIFont.boldSystemFont(ofSize: jogajaOrganicLabelConnection.font.pointSize)
            jogajaOrganicLabelConnection.isHidden = false
            self.buttonBackJogjaOrganic.isHidden = true
            self.buttonForwardJogjaOrganic.isHidden = true
            //Color
            view.backgroundColor = .black
        }
        
    }

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
        
        return (isReachable && !needsConnection)
    }
    
}
