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
        scoreContainerView.layer.cornerRadius = scoreContainerView.bounds.width / 2
        scoreContainerView.layer.borderWidth = 2
        scoreContainerView.layer.borderColor = UIColor.black.cgColor
        
        circularProgressView.layer.cornerRadius = circularProgressView.bounds.width / 2
        
        scoreInfoContainerView.layer.cornerRadius = scoreContainerView.bounds.width / 2
    }
    
}
