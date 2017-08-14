//
//  ViewController.swift
//  Jogja Organic
//
//  Created by Dan Bo on 7/24/17.
//  Copyright © 2017 com.eightstudio.www. All rights reserved.
//

import UIKit

class JogjaOrganic: UIViewController {
    

    
    @IBOutlet weak var myWorldWebView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL (string: "http://www.jogjaorganik.com/");
        let requestObj = NSURLRequest(url: url! as URL);
        myWorldWebView.loadRequest(requestObj as URLRequest);
        
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
    
}
