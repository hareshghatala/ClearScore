//
//  DashboardViewController.swift
//  Clear Score Credit
//
//  Created by Haresh Ghatala on 9/2/22.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var scoreContainerView: UIView!
    @IBOutlet weak var circularProgressView: UIView!
    @IBOutlet weak var scoreInfoContainerView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var maxScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
    }
    
    func setupView() {
        self.scoreContainerView.layer.cornerRadius = self.scoreContainerView.frame.width / 2
        self.scoreContainerView.layer.borderWidth = 2
        self.scoreContainerView.layer.borderColor = UIColor.black.cgColor
        
        self.circularProgressView.layer.cornerRadius = self.circularProgressView.frame.width / 2
        
        self.scoreInfoContainerView.layer.cornerRadius = self.scoreInfoContainerView.frame.width / 2
    }
    
}
