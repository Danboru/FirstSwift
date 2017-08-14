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

    
    @IBOutlet weak var mySportWebView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL (string: "https://berdu.id/cek-resi");
        let requestObj = NSURLRequest(url: url! as URL);
        mySportWebView.loadRequest(requestObj as URLRequest);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func berduBack(_ sender: Any) {
        mySportWebView.goBack()
    }
    
    @IBAction func berduForward(_ sender: Any) {
        mySportWebView.goForward()
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
