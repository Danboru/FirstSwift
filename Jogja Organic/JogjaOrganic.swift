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
    

    @IBOutlet weak var jogajaOrganicLabelConnection: UILabel!
    
    @IBOutlet weak var myWorldWebView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if connectedToNetwork() == true {
            jogajaOrganicLabelConnection.isHidden = true
            
            // Do any additional setup after loading the view, typically from a nib.
            let url = NSURL (string: "http://www.jogjaorganik.com/");
            let requestObj = NSURLRequest(url: url! as URL);
            myWorldWebView.loadRequest(requestObj as URLRequest);
        } else {
            jogajaOrganicLabelConnection.isHidden = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func jogjaOrganicBack(_ sender: Any) {
        myWorldWebView.goBack()
    }
 
    @IBAction func jogjaOrganicForward(_ sender: Any) {
        myWorldWebView.goForward()
    }
    
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
